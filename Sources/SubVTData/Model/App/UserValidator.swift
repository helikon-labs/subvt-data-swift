/**
 One of the user's validators.
 */
public struct UserValidator: Hashable {
    public let id: UInt64
    public let userId: UInt64
    public let networkId: UInt64
    public let validatorAccountId: AccountId
    
    public init(
        id: UInt64,
        userId: UInt64,
        networkId: UInt64,
        validatorAccountId: AccountId
    ) {
        self.id = id
        self.userId = userId
        self.networkId = networkId
        self.validatorAccountId = validatorAccountId
    }
}

extension UserValidator: Codable {}

public struct NewUserValidator: Hashable {
    public let networkId: UInt64
    public let validatorAccountId: AccountId
    
    public init(
        networkId: UInt64,
        validatorAccountId: AccountId
    ) {
        self.networkId = networkId
        self.validatorAccountId = validatorAccountId
    }
}

extension NewUserValidator: Codable {}
