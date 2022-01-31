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
}
