/**
 One of the user's validators.
 */
public struct UserValidator: Codable {
    public let id: UInt64
    public let userId: UInt64
    public let networkId: UInt64
    public let validatorAccountId: AccountId
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case networkId = "network_id"
        case validatorAccountId = "validator_account_id"
    }
}

public struct NewUserValidator: Codable {
    public let networkId: UInt64
    public let validatorAccountId: AccountId
    
    private enum CodingKeys: String, CodingKey {
        case networkId = "network_id"
        case validatorAccountId = "validator_account_id"
    }
}
