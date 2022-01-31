/**
 Era staker account id, total staked amount and active amount.
 */
public struct Stake: Codable {
    public let stashAccountId: AccountId
    public let totalAmount: Balance
    public let activeAmount: Balance
    
    private enum CodingKeys: String, CodingKey {
        case stashAccountId = "stash_account_id"
        case totalAmount = "total_amount"
        case activeAmount = "active_amount"
    }
}

public struct StakeSummary: Codable {
    public let stashAccountId: String
    public let activeAmount: Balance
    
    private enum CodingKeys: String, CodingKey {
        case stashAccountId = "stash_account_id"
        case activeAmount = "active_amount"
    }
}
