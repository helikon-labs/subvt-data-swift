/**
 Report for a single era.
 */
public struct EraReport: Hashable {
    public let era: Era
    public let minimumStake: Balance?
    public let maximumStake: Balance?
    public let averageStake: Balance?
    public let medianStake: Balance?
    public let totalValidatorReward: Balance?
    public let totalRewardPoints: UInt64?
    public let totalReward: Balance
    public let totalStake: Balance?
    public let activeValidatorCount: UInt32
    public let inactiveValidatorCount: UInt32
    public let activeNominatorCount: UInt64?
    public let offlineOffenceCount: UInt64
    public let slashedAmount: Balance
    public let chillingCount: UInt64
    
    public init(
        era: Era,
        minimumStake: Balance?,
        maximumStake: Balance?,
        averageStake: Balance?,
        medianStake: Balance?,
        totalValidatorReward: Balance?,
        totalRewardPoints: UInt64?,
        totalReward: Balance,
        totalStake: Balance?,
        activeValidatorCount: UInt32,
        inactiveValidatorCount: UInt32,
        activeNominatorCount: UInt64?,
        offlineOffenceCount: UInt64,
        slashedAmount: Balance,
        chillingCount: UInt64
    ) {
        self.era = era
        self.minimumStake = minimumStake
        self.maximumStake = maximumStake
        self.averageStake = averageStake
        self.medianStake = medianStake
        self.totalValidatorReward = totalValidatorReward
        self.totalRewardPoints = totalRewardPoints
        self.totalReward = totalReward
        self.totalStake = totalStake
        self.activeValidatorCount = activeValidatorCount
        self.inactiveValidatorCount = inactiveValidatorCount
        self.activeNominatorCount = activeNominatorCount
        self.offlineOffenceCount = offlineOffenceCount
        self.slashedAmount = slashedAmount
        self.chillingCount = chillingCount
    }
}

extension EraReport: Codable {}
