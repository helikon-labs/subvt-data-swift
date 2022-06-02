/**
 Generic RPC request.
 */
struct RPCRequest<T: Encodable>: Encodable {
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

/**
 Initial response received after a successful subscription request.
 */
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

/**
 Initial response received after a successful unsubscription request.
 */
struct RPCUnsubscribeResponse: Codable {
    let jsonrpc: String
    let id: UInt64
    let result: Bool
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
        case result
    }
}

/**
 Published message for a subscription.
 Starts being published after the first message of type `RPCSubscribeResponse`.
 */
struct RPCPublishedMessage<T: Codable>: Codable {
    let jsonrpc: String
    let method: String
    let params: RPCPublishedMessageParams<T>
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case method
        case params
    }
}

/**
 Contains the actual data inside a published message.
 */
struct RPCPublishedMessageParams<T: Codable>: Codable {
    let subscriptionId: UInt64
    let body: T
    
    private enum CodingKeys: String, CodingKey {
        case subscriptionId = "subscription"
        case body = "result"
    }
}

/**
 RPC service backend error body.
 */
struct RPCBackendErrorResponse: Codable {
    let jsonrpc: String
    let id: UInt64
    let error: RPCBackendError
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
        case error
    }
}

/**
 RPC error body inner error data.
 */
struct RPCBackendError: Codable {
    let code: Int
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
