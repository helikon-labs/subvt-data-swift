/**
 Complete staking information for an active validator account.
 */
public struct ValidatorStake: Codable {
    public let account: Account
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominators: [NominatorStake]
}


public struct ValidatorStakeSummary: Codable {
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominatorCount: Int
}
