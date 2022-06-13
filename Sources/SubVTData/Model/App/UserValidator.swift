/**
 One of the user's validators.
 */
public struct UserValidator {
    public let id: UInt64
    public let userId: UInt64
    public let networkId: UInt64
    public let validatorAccountId: AccountId
}

extension UserValidator: Codable {}

public struct NewUserValidator {
    public let networkId: UInt64
    public let validatorAccountId: AccountId
}

extension NewUserValidator: Codable {}
