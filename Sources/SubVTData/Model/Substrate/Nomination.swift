/**
 Nominator, stake an nominees.
 */
public struct Nomination: Codable {
    public let stashAccountId: AccountId
    public let submissionEraIndex: Int
    public let targetAccountIds: [String]
    public let stake: Stake
}


public struct InactiveNominationsSummary: Codable {
    public let nominationCount: Int
    public let totalAmount: Balance
}
