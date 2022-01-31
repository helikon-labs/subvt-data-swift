/**
 Complete staking information for an active validator account.
 */
public struct ValidatorStake: Codable {
    public let account: Account
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominators: [NominatorStake]
    
    private enum CodingKeys: String, CodingKey {
        case account
        case selfStake = "self_stake"
        case totalStake = "total_stake"
        case nominators
    }
}


public struct ValidatorStakeSummary: Codable {
    public let selfStake: Balance
    public let totalStake: Balance
    public let nominatorCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case selfStake = "self_stake"
        case totalStake = "total_stake"
        case nominatorCount = "nominator_count"
    }
}
