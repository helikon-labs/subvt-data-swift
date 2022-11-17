/**
 Summarized data for a 1KV nominator.
 */
public struct OneKVNominatorSummary: Hashable, Codable {
    public let id: UInt64
    public let onekvId: String
    public let stashAccountId: AccountId
    public let stashAddress: String
    public let bondedAmount: Balance
    public let lastNominationAt: UInt64
}
