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
}
