/**
 Complete staking information for an active validator account.
 */
public struct ValidatorStake {
    public let account: Account
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominators: [NominatorStake]
}

extension ValidatorStake: Codable {}

public struct ValidatorStakeSummary {
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominatorCount: Int
}

extension ValidatorStakeSummary: Codable {}
