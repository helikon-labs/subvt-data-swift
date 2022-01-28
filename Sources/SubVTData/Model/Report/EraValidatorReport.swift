/**
 Report for a single era-validator.
 */
public struct EraValidatorReport: Codable {
    public let era: Era
    public let isActive: Bool?
    public let commissionPerBillion: UInt64?
    public let selfStake: Balance?
    public let totalStake: Balance?
    public let blockCount: UInt32
    public let rewardPoints: Balance?
    public let selfReward: Balance
    public let stakerReward: Balance
    public let offlineOffenceCount: UInt16
    public let slashedAmount: Balance
    public let chillingCount: UInt16
    
    private enum CodingKeys: String, CodingKey {
        case era
        case isActive = "is_active"
        case commissionPerBillion = "commission_per_billion"
        case selfStake = "self_stake"
        case totalStake = "total_stake"
        case blockCount = "block_count"
        case rewardPoints = "reward_points"
        case selfReward = "self_reward"
        case stakerReward = "staker_reward"
        case offlineOffenceCount = "offline_offence_count"
        case slashedAmount = "slashed_amount"
        case chillingCount = "chilling_count"
    }
}
