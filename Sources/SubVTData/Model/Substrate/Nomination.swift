/**
 Nominator, stake an nominees.
 */
public struct Nomination {
    public let stashAccount: Account
    public let submissionEraIndex: Int
    public let targetAccountIds: [String]
    public let stake: Stake
}

extension Nomination: Codable {}


public struct InactiveNominationsSummary {
    public let nominationCount: Int
    public let totalAmount: Balance
}

extension InactiveNominationsSummary: Codable {}
