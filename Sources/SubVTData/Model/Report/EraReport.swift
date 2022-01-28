/**
 Report for a single era.
 */
public struct EraReport: Codable {
    public let era: Era
    public let minimumStake: Balance?
    public let maximumStake: Balance?
    public let averageStake: Balance?
    public let medianStake: Balance?
    public let totalValidatorReward: Balance?
    public let totalRewardPoints: UInt64?
    public let totalReward: Balance
    public let totalStake: Balance?
    public let activeNominatorCount: UInt64?
    public let offlineOffenceCount: UInt64
    public let slashedAmount: Balance
    public let chillingCount: UInt64
    
    private enum CodingKeys: String, CodingKey {
        case era
        case minimumStake = "minimum_stake"
        case maximumStake = "maximum_stake"
        case averageStake = "average_stake"
        case medianStake = "median_stake"
        case totalValidatorReward = "total_validator_reward"
        case totalRewardPoints = "total_reward_points"
        case totalReward = "total_reward"
        case totalStake = "total_stake"
        case activeNominatorCount = "active_nominator_count"
        case offlineOffenceCount = "offline_offence_count"
        case slashedAmount = "slashed_amount"
        case chillingCount = "chilling_count"
    }
}
