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

struct RPCUnsubscribeResponse: Codable {
    let jsonrpc: String
    let id: UInt64
    let result: String
    
    private enum CodingKeys: String, CodingKey {
        case jsonrpc
        case id
        case result
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
