/**
 Complete staking information for an active validator account.
 */
public struct ValidatorStake {
    public let account: Account
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominators: [NominatorStake]
    
    public init(
        account: Account,
        selfStake: Balance,
        totalStake: Balance,
        nominators: [NominatorStake]
    ) {
        self.account = account
        self.selfStake = selfStake
        self.totalStake = totalStake
        self.nominators = nominators
    }
}

extension ValidatorStake: Codable {}

public struct ValidatorStakeSummary {
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominatorCount: Int
    
    public init(
        selfStake: Balance,
        totalStake: Balance,
        nominatorCount: Int
    ) {
        self.selfStake = selfStake
        self.totalStake = totalStake
        self.nominatorCount = nominatorCount
    }
}

extension ValidatorStakeSummary: Codable {}
