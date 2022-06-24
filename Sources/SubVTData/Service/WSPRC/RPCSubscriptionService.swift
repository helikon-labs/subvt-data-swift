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
    
    private let eventBus = PassthroughSubject<RPCEvent<T>, RPCError>()
    
    init(
        host: String,
        port: UInt16,
        subscribeMethod: String,
        unsubscribeMethod: String
    ) {
        self.host = host
        self.port = port
        self.subscribeMethod = subscribeMethod
        self.unsubscribeMethod = unsubscribeMethod
        let url = URL(
            string: "https://\(host):\(port)"
        )!
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .binary(_):
            break
        case .cancelled:
            status = .idle
            eventBus.send(completion: .finished)
        case .connected(_):
            status = .connected
            sendSubscriptionRequest()
        case .disconnected(let reason, let code):
            switch status {
            case .error(let error):
                eventBus.send(
                    completion: .failure(
                        RPCError.error(
                            error: error
                        )
                    )
                )
            case .subscribed(_):
                eventBus.send(
                    completion: .failure(
                        RPCError.disconnected(
                            code: code,
                            reason: reason
                        )
                    )
                )
            case .unsubscribed:
                eventBus.send(completion: .finished)
            default:
                break
            }
            status = .disconnected(
                code: code,
                reason: reason
            )
        case .error(let error):
            status = .error(error: error)
            eventBus.send(
                completion: .failure(
                    RPCError.error(
                        error: error
                    )
                )
            )
            socket.disconnect()
        case .ping(_):
            break
        case .pong(_):
            break
        case .reconnectSuggested(let isSuggested):
            if isSuggested {
                eventBus.send(
                    RPCEvent.reconnectSuggested
                )
            }
        case .text(let text):
            processText(text: text)
        case .viabilityChanged(_):
            break
        }
    }
    
    public func subscribe(parameter: String? = nil) -> AnyPublisher<RPCEvent<T>, RPCError> {
        subscriptionParameter = parameter
        switch status {
        case .disconnected(_, _):
            fallthrough
        case .idle:
            socket.connect()
        default:
            break
        }
        return eventBus.eraseToAnyPublisher()
    }
    
    public func unsubscribe() {
        guard case .subscribed(let subscriptionId) = status else {
            return
        }
        let request = RPCRequest<UInt64>(
            id: rpcId,
            method: unsubscribeMethod,
            params: [subscriptionId]
        )
        if let jsonData = try? jsonEncoder.encode(request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            socket.write(string: jsonString)
        } else {
            fatalError("Cannot encode unsubscription request data.")
        }
    }
    
    private func sendSubscriptionRequest() {
        rpcId = UInt64.random(in: 0...UInt64.max)
        var params = [String]()
        if let parameter = subscriptionParameter {
            params.append(parameter)
        }
        subscriptionParameter = nil
        let request = RPCRequest(
            id: rpcId,
            method: subscribeMethod,
            params: params
        )
        if let jsonData = try? jsonEncoder.encode(request),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            socket.write(string: jsonString)
        } else {
            fatalError("Cannot encode subscription request data.")
        }
    }
    
    private func processText(text: String) {
        if let data = text.data(using: .utf8) {
            do {
                switch status {
                case .connected:
                    let response = try jsonDecoder.decode(
                        RPCSubscribeResponse.self,
                        from: data
                    )
                    status = .subscribed(
                        subscriptionId: response.subscriptionId
                    )
                    eventBus.send(
                        RPCEvent.subscribed(
                            subscriptionId: response.subscriptionId
                        )
                    )
                case .subscribed(let subscriptionId):
                    do {
                        let update = try jsonDecoder.decode(
                            RPCPublishedMessage<T>.self,
                            from: data
                        )
                        if update.params.subscriptionId != subscriptionId {
                            break
                        }
                        eventBus.send(
                            RPCEvent.update(update.params.body)
                        )
                    } catch {
                        let _ = try jsonDecoder.decode(
                            RPCUnsubscribeResponse.self,
                            from: data
                        )
                        eventBus.send(RPCEvent.unsubscribed)
                        status = .unsubscribed
                        socket.disconnect()
                    }
                default:
                    break
                }
            } catch {
                do {
                    let backendError = try jsonDecoder.decode(
                        RPCBackendErrorResponse.self,
                        from: data
                    )
                    eventBus.send(
                        completion: .failure(
                            RPCError.backendError(
                                code: backendError.error.code,
                                message: backendError.error.message
                            )
                        )
                    )
                    status = .error(error: nil)
                } catch {
                    eventBus.send(
                        completion: .failure(
                            RPCError.error(
                                error: error
                            )
                        )
                    )
                    status = .error(error: error)
                }
                socket.disconnect()
            }
        } else {
            eventBus.send(
                completion: .failure(
                    RPCError.dataReadError
                )
            )
            status = .error(error: nil)
            socket.disconnect()
        }
    }
}
