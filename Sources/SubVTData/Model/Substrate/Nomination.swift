/**
 Nominator, stake an nominees.
 */
public struct Nomination: Hashable {
    public let stashAccount: Account
    public let submissionEraIndex: Int
    public let targetAccountIds: [String]
    public let stake: Stake
    
    public init(
        stashAccount: Account,
        submissionEraIndex: Int,
        targetAccountIds: [String],
        stake: Stake
    ) {
        self.stashAccount = stashAccount
        self.submissionEraIndex = submissionEraIndex
        self.targetAccountIds = targetAccountIds
        self.stake = stake
    }
}

extension Nomination: Codable {}


public struct InactiveNominationsSummary: Hashable {
    public let nominationCount: Int
    public let totalAmount: Balance
    
    public init(
        nominationCount: Int,
        totalAmount: Balance
    ) {
        self.nominationCount = nominationCount
        self.totalAmount = totalAmount
    }
}

extension InactiveNominationsSummary: Codable {}
