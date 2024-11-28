import Combine
import Foundation

private let timeoutSeconds = 5.0
private let pingPeriodSeconds = 30.0

public enum RPCEvent<T: Codable> {
    case subscribed(subscriptionId: UInt64)
    case unsubscribed
    case update(T)
}

public enum RPCError: Error {
    case backend(error: Error)
    case send(error: Error)
    case connection
    case other(error: Error)
    case ping(error: Error)
    case receive(error: Error)
}

public enum RPCSubscriptionServiceStatus {
    case connected
    case disconnected
    case error(error: RPCError)
    case idle
    case subscribed(subscriptionId: UInt64)
    case unsubscribed
}

/**
 Base class for RPC pub/sub services.
 */
public class RPCSubscriptionService<T: Codable>: NSObject, ObservableObject, URLSessionWebSocketDelegate {
    private let subscribeMethod: String
    private let unsubscribeMethod: String
    
    private let url: URL
    private var task: URLSessionWebSocketTask? = nil
    private var pingTimer: Timer? = nil
    
    @Published public private(set) var status: RPCSubscriptionServiceStatus = .idle
    private var rpcId: UInt64 = 0
    private var subscriptionParameter: String? = nil
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private var eventBus: PassthroughSubject<RPCEvent<T>, RPCError>!
    
    init(
        host: String,
        port: UInt16,
        subscribeMethod: String,
        unsubscribeMethod: String
    ) {
        log.debug("⬆️ Init RPC subscription service.")
        let scheme = Settings.shared.useSSL ? "wss" : "ws"
        let urlString = "\(scheme)://\(host):\(port)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid host/port resulting in: \(urlString)")
        }
        self.url = url
        self.subscribeMethod = subscribeMethod
        self.unsubscribeMethod = unsubscribeMethod
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        super.init()
    }
    
    deinit {
        log.debug("⬇️ Deinit RPC subscription service.")
        switch self.status {
        case .subscribed(_):
            self.unsubscribe()
        case .connected:
            self.task?.cancel(with: .normalClosure, reason: nil)
        default:
            break
        }
    }
    
    private func closeConnectionWithError(_ error: RPCError) {
        switch self.status {
        case .idle:
            log.error("❌ No connection.")
            self.eventBus.send(completion: .failure(error))
            self.status = .disconnected
            self.task?.cancel(with: .abnormalClosure, reason: nil)
        default:
            self.pingTimer?.invalidate()
            self.status = .error(error: error)
            self.task?.cancel(with: .abnormalClosure,reason: nil)
        }
    }
    
    public func subscribe(parameter: String? = nil) -> AnyPublisher<RPCEvent<T>, RPCError> {
        self.subscriptionParameter = parameter
        switch status {
        case .idle, .disconnected, .error:
            self.eventBus = PassthroughSubject<RPCEvent<T>, RPCError>()
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
            session.configuration.timeoutIntervalForRequest = timeoutSeconds
            self.task = session.webSocketTask(with: url)
            self.task?.maximumMessageSize = 1024 * 1024 * 2
            self.receive()
            self.task?.resume()
        default:
            break
        }
        return self.eventBus.eraseToAnyPublisher()
    }
    
    private func sendSubscriptionRequest() {
        self.rpcId = UInt64.random(in: 0...UInt64.max)
        var params = [String]()
        if let parameter = self.subscriptionParameter {
            params.append(parameter)
        }
        self.subscriptionParameter = nil
        let request = RPCRequest(
            id: self.rpcId,
            method: subscribeMethod,
            params: params
        )
        if let jsonData = try? self.jsonEncoder.encode(request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            self.task?.send(message) {
                [weak self] error in
                guard let error = error else { return }
                log.error("❌ Cannot send subscription request data.")
                self?.closeConnectionWithError(.send(error: error))
            }
        } else {
            fatalError("❌ Cannot encode subscription request data.")
        }
    }
    
    public func unsubscribe() {
        guard case .subscribed(let subscriptionId) = status else {
            return
        }
        let request = RPCRequest<UInt64>(
            id: self.rpcId,
            method: self.unsubscribeMethod,
            params: [subscriptionId]
        )
        if let jsonData = try? self.jsonEncoder.encode(request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            let message = URLSessionWebSocketTask.Message.string(jsonString)
            self.task?.send(message) {
                [weak self] error in
                guard let error = error else { return }
                log.error("❌ Cannot send unsubscription request data.")
                self?.closeConnectionWithError(.send(error: error))
            }
        } else {
            fatalError("❌ Cannot encode unsubscription request data.")
        }
    }
    
    private func setupPingTimer() {
        self.pingTimer = Timer.scheduledTimer(
            withTimeInterval: pingPeriodSeconds,
            repeats: true
        ) { [weak self] timer in
            self?.task?.sendPing(
                pongReceiveHandler: {
                    [weak self] error in
                    guard let error = error else { return }
                    log.error("❌ Ping request failed.")
                    self?.closeConnectionWithError(.ping(error: error))
                }
            )
        }
    }
    
    func receive()  {
        self.task?.receive { result in
            switch result {
            case .failure(let error):
                log.error("❌ Message receive error: \(error.localizedDescription)")
                self.closeConnectionWithError(.receive(error: error))
            case .success(let message):
                switch message {
                case .string(let text):
                    self.processText(text: text)
                case .data:
                    // ignore binary message
                    break
                @unknown default:
                    fatalError("❌ Unknown message type from WS-RPC service.")
                }
                switch self.status {
                case .connected, .idle, .subscribed:
                    self.receive()
                default:
                    break
                }
            }
        }
    }
    
    private func processText(text: String) {
        if let data = text.data(using: .utf8) {
            do {
                switch self.status {
                case .connected:
                    let response = try self.jsonDecoder.decode(
                        RPCSubscribeResponse.self,
                        from: data
                    )
                    self.status = .subscribed(
                        subscriptionId: response.subscriptionId
                    )
                    log.debug("🤝 RPC subscription service subscribed.")
                    self.eventBus.send(RPCEvent.subscribed(
                        subscriptionId: response.subscriptionId
                    ))
                case .subscribed(let subscriptionId):
                    do {
                        let update = try self.jsonDecoder.decode(
                            RPCPublishedMessage<T>.self,
                            from: data
                        )
                        if update.params.subscriptionId != subscriptionId {
                            break
                        }
                        self.eventBus.send(RPCEvent.update(
                            update.params.body
                        ))
                    } catch {
                        let _ = try self.jsonDecoder.decode(
                            RPCUnsubscribeResponse.self,
                            from: data
                        )
                        log.debug("👋 RPC subscription service unsubscribed.")
                        self.eventBus.send(RPCEvent.unsubscribed)
                        self.status = .unsubscribed
                        self.task?.cancel(with: .goingAway, reason: nil)
                    }
                default:
                    break
                }
            } catch {
                do {
                    let response = try self.jsonDecoder.decode(
                        RPCBackendErrorResponse.self,
                        from: data
                    )
                    let errorMessage = response.error.message
                    log.debug("❌ RPC subscription service backend error: \(errorMessage)")
                    self.closeConnectionWithError(.backend(error: response.error))
                } catch {
                    log.debug("❌ RPC subscription service error: \(error.localizedDescription)")
                    self.closeConnectionWithError(.other(error: error))
                }
            }
        } else {
            log.debug("❌ RPC subscription service data read error.")
            self.task?.cancel(with: .abnormalClosure, reason: nil)
        }
    }
    
    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        log.debug("🟢 RPC subscription service connection opened.")
        self.status = .connected
        self.sendSubscriptionRequest()
        DispatchQueue.main.async {
            self.setupPingTimer()
        }
    }

    public func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didCloseWith code: URLSessionWebSocketTask.CloseCode,
        reason: Data?
    ) {
        log.debug("🔴 RPC subscription service connection closed.")
        self.pingTimer?.invalidate()
        switch code {
        case .goingAway, .normalClosure:
            self.eventBus.send(completion: .finished)
            self.status = .idle
        case .abnormalClosure:
            switch self.status {
            case .disconnected:
                break
            case .error(let error):
                self.eventBus.send(completion: .failure(error))
            default:
                self.eventBus.send(completion: .failure(.connection))
                self.status = .disconnected
            }
        default:
            self.eventBus.send(completion: .failure(.connection))
            self.status = .disconnected
        }
    }
}
