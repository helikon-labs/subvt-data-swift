/**
 Era staker account id, total staked amount and active amount.
 */
public struct Stake: Codable {
    public let stashAccountId: AccountId
    public let totalAmount: Balance
    public let activeAmount: Balance
}

public struct StakeSummary: Codable {
    public let stashAccountId: String
    public let activeAmount: Balance
}
