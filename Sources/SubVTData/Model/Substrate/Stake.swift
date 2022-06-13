/**
 Era staker account id, total staked amount and active amount.
 */
public struct Stake {
    public let stashAccountId: AccountId
    public let totalAmount: Balance
    public let activeAmount: Balance
}

extension Stake: Codable {}

public struct StakeSummary {
    public let stashAccountId: AccountId
    public let activeAmount: Balance
}

extension StakeSummary: Codable {}
