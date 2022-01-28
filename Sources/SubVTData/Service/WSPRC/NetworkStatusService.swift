import Combine
import Foundation
import Starscream

struct RPCRequest<T: Codable>: Codable {
    let jsonrpc: String
    let id: UInt64
    let method: String
    let params: [T]
    
    init(
        id: UInt64,
        method: String,
        params: [T]
    ) {
        jsonrpc = "2.0"
        self.id = id
        self.method = method
        self.params = params
    }
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
        case method
        case params
    }
}

struct RPCSubscribeResponse: Codable {
    let jsonrpc: String
    let id: UInt64
    let subscriptionId: UInt64
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
        case subscriptionId = "result"
    }
}

struct RPCSubscriptionMessage<T: Codable>: Codable {
    let jsonrpc: String
    let method: String
    let params: RPCSubscriptionMessageParams<T>
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case method
        case params
    }
}

struct RPCSubscriptionMessageParams<T: Codable>: Codable {
    let subscriptionId: UInt64
    let body: T
    
    private enum CodingKeys: String, CodingKey {
        case subscriptionId = "subscription"
        case body = "result"
    }
}

enum RPCEvent<T: Codable> {
    case update(T)
}

enum RPCError: Error {
    case error
}

class RPCSubscriptionService<T: Codable>: WebSocketDelegate {
    private enum State {
        case idle
        case disconnected(code: UInt16, reason: String)
        case connected
        case subscribed(subscriptionId: UInt64)
        case cancelled
        case error(error: Error?)
    }
    
    private let host: String
    private let port: UInt16
    private let subscribeMethod: String
    private let unsubscribeMethod: String
    private let socket: WebSocket
    
    private var state = State.idle
    private var rpcId: UInt64 = 0
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    private let subject = PassthroughSubject<RPCEvent<T>, RPCError>()
    
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
            string: "http://\(Settings.shared.apiHost):\(Settings.shared.networkStatusServicePort)"
        )!
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        self.socket = WebSocket(request: request)
        self.socket.delegate = self
    }
    
    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(_):
            state = .connected
            sendSubscriptionRequest()
        case .disconnected(let reason, let code):
            // TODO emit disconnected
            state = .disconnected(
                code: code,
                reason: reason
            )
        case .text(let text):
            processText(text: text)
        case .binary(_):
            break
        case .ping(_):
            break
        case .pong(_):
            break
        case .viabilityChanged(_):
            break
        case .reconnectSuggested(_):
            // TODO emit
            break
        case .cancelled:
            // TODO emit
            state = .cancelled
            break
        case .error(let error):
            // TODO emit
            state = .error(error: error)
        }
    }
    
    func subscribe() -> AnyPublisher<RPCEvent<T>, RPCError> {
        switch state {
        case .cancelled:
            fallthrough
        case .disconnected(_, _):
            fallthrough
        case .idle:
            socket.connect()
        default:
            break
        }
        return subject.eraseToAnyPublisher()
    }
    
    func unsubscribe() {
        let request = RPCRequest<String>(
            id: rpcId,
            method: unsubscribeMethod,
            params: []
        )
        let jsonData = try! jsonEncoder.encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        socket.write(string: jsonString)
    }
    
    private func sendSubscriptionRequest() {
        rpcId = UInt64.random(in: 0...UInt64.max)
        let request = RPCRequest<String>(
            id: rpcId,
            method: subscribeMethod,
            params: []
        )
        let jsonData = try! jsonEncoder.encode(request)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        socket.write(string: jsonString)
    }
    
    private func processText(text: String) {
        if let data = text.data(using: .utf8) {
            do {
                switch state {
                case .connected:
                    let response = try jsonDecoder.decode(
                        RPCSubscribeResponse.self,
                        from: data
                    )
                    state = .subscribed(subscriptionId: response.subscriptionId)
                    // emit connected
                case .subscribed(let subscriptionId):
                    let update = try jsonDecoder.decode(
                        RPCSubscriptionMessage<T>.self,
                        from: data
                    )
                    if update.params.subscriptionId != subscriptionId {
                        break
                    }
                    subject.send(
                        RPCEvent.update(update.params.body)
                    )
                default:
                    break
                }
            } catch {
                subject.send(
                    completion: .failure(RPCError.error)
                )
            }
        } else {
            subject.send(
                completion: .failure(RPCError.error)
            )
        }
    }
}
