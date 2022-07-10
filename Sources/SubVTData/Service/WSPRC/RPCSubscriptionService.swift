import Combine
import Foundation
import Starscream

public enum RPCEvent<T: Codable> {
    case reconnectSuggested
    case subscribed(subscriptionId: UInt64)
    case unsubscribed
    case update(T)
}

public enum RPCError: Error {
    case dataReadError
    case disconnected(code: UInt16, reason: String)
    case backendError(code: Int, message: String)
    case error(error: Error?)
}

public enum RPCSubscriptionServiceStatus {
    case connected
    case disconnected(code: UInt16, reason: String)
    case error(error: Error?)
    case idle
    case subscribed(subscriptionId: UInt64)
    case unsubscribed
}

/**
 Base class for RPC pub/sub services.
 */
public class RPCSubscriptionService<T: Codable>: ObservableObject, WebSocketDelegate {
    private let host: String
    private let port: UInt16
    private let subscribeMethod: String
    private let unsubscribeMethod: String
    private let socket: WebSocket
    
    @Published public private(set) var status = RPCSubscriptionServiceStatus.idle
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
        self.host = host
        self.port = port
        self.subscribeMethod = subscribeMethod
        self.unsubscribeMethod = unsubscribeMethod
        let url = URL(
            string: "https://\(host):\(port)"
        )!
        var request = URLRequest(url: url)
        request.timeoutInterval = 100
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    deinit {
        log.debug("⬇️ Deinit RPC subscription service.")
        switch self.status {
        case .subscribed(_):
            self.unsubscribe()
        case .connected:
            self.socket.disconnect()
        default:
            break
        }
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .binary(_):
            break
        case .cancelled:
            self.status = .idle
            self.eventBus.send(completion: .finished)
        case .connected(_):
            log.debug("🟢 RPC subscription service connected.")
            self.status = .connected
            self.sendSubscriptionRequest()
        case .disconnected(let reason, let code):
            log.debug("🔴 RPC subscription service disconnected.")
            switch self.status {
            case .error(let error):
                self.eventBus.send(
                    completion: .failure(
                        RPCError.error(
                            error: error
                        )
                    )
                )
            case .subscribed(_):
                self.eventBus.send(
                    completion: .failure(
                        RPCError.disconnected(
                            code: code,
                            reason: reason
                        )
                    )
                )
            case .unsubscribed:
                self.eventBus.send(completion: .finished)
            default:
                break
            }
            self.status = .disconnected(
                code: code,
                reason: reason
            )
        case .error(let error):
            log.debug("❌ RPC subscription service error: \(error?.localizedDescription ?? "no message")")
            self.status = .error(error: error)
            self.eventBus.send(
                completion: .failure(
                    RPCError.error(
                        error: error
                    )
                )
            )
            self.socket.disconnect()
        case .ping(_):
            break
        case .pong(_):
            break
        case .reconnectSuggested(let isSuggested):
            log.debug("⚠️ RPC subscription service reconnect suggested.")
            if isSuggested {
                self.eventBus.send(
                    RPCEvent.reconnectSuggested
                )
            }
        case .text(let text):
            self.processText(text: text)
        case .viabilityChanged(_):
            break
        }
    }
    
    public func subscribe(parameter: String? = nil) -> AnyPublisher<RPCEvent<T>, RPCError> {
        self.subscriptionParameter = parameter
        switch status {
        case .disconnected(_, _):
            fallthrough
        case .idle:
            self.eventBus = PassthroughSubject<RPCEvent<T>, RPCError>()
            self.socket.connect()
        default:
            break
        }
        return self.eventBus.eraseToAnyPublisher()
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
            socket.write(string: jsonString)
        } else {
            fatalError("❌ Cannot encode unsubscription request data.")
        }
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
            self.socket.write(string: jsonString)
        } else {
            fatalError("❌ Cannot encode subscription request data.")
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
                    self.eventBus.send(
                        RPCEvent.subscribed(
                            subscriptionId: response.subscriptionId
                        )
                    )
                case .subscribed(let subscriptionId):
                    do {
                        let update = try self.jsonDecoder.decode(
                            RPCPublishedMessage<T>.self,
                            from: data
                        )
                        if update.params.subscriptionId != subscriptionId {
                            break
                        }
                        self.eventBus.send(
                            RPCEvent.update(update.params.body)
                        )
                    } catch {
                        let _ = try self.jsonDecoder.decode(
                            RPCUnsubscribeResponse.self,
                            from: data
                        )
                        log.debug("👋 RPC subscription service unsubscribed.")
                        self.eventBus.send(RPCEvent.unsubscribed)
                        self.status = .unsubscribed
                        self.socket.disconnect()
                    }
                default:
                    break
                }
            } catch {
                do {
                    let backendError = try self.jsonDecoder.decode(
                        RPCBackendErrorResponse.self,
                        from: data
                    )
                    log.debug("❌ RPC subscription service backend error: \(backendError.error.message)")
                    self.eventBus.send(
                        completion: .failure(
                            RPCError.backendError(
                                code: backendError.error.code,
                                message: backendError.error.message
                            )
                        )
                    )
                    status = .error(error: nil)
                } catch {
                    self.eventBus.send(
                        completion: .failure(
                            RPCError.error(
                                error: error
                            )
                        )
                    )
                    log.debug("❌ RPC subscription service error: \(error.localizedDescription)")
                    self.status = .error(error: error)
                }
                self.socket.disconnect()
            }
        } else {
            self.eventBus.send(
                completion: .failure(
                    RPCError.dataReadError
                )
            )
            log.debug("❌ RPC subscription service data read error.")
            self.status = .error(error: nil)
            self.socket.disconnect()
        }
    }
}
