/**
 One of the user's validators.
 */
public struct UserValidator: Codable {
    public let id: UInt64
    public let userId: UInt64
    public let networkId: UInt64
    public let validatorAccountId: AccountId
}

public struct NewUserValidator: Codable {
    public let networkId: UInt64
    public let validatorAccountId: AccountId
}
