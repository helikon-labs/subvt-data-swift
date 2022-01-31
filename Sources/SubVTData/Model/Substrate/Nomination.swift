/**
 Nominator, stake an nominees.
 */
public struct Nomination: Codable {
    public let stashAccountId: AccountId
    public let submissionEraIndex: Int
    public let targetAccountIds: [String]
    public let stake: Stake
    
    private enum CodingKeys: String, CodingKey {
        case stashAccountId = "stash_account_id"
        case submissionEraIndex = "submission_era_index"
        case targetAccountIds = "target_account_ids"
        case stake
    }
}


public struct InactiveNominationsSummary: Codable {
    public let nominationCount: Int
    public let totalAmount: Balance
    
    private enum CodingKeys: String, CodingKey {
        case nominationCount = "nomination_count"
        case totalAmount = "total_amount"
    }
}
