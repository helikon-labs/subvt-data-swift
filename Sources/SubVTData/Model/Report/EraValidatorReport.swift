/**
 Report for a single era-validator.
 */
public struct EraValidatorReport {
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
    
    public init(
        era: Era,
        isActive: Bool?,
        commissionPerBillion: UInt64?,
        selfStake: Balance?,
        totalStake: Balance?,
        blockCount: UInt32,
        rewardPoints: Balance?,
        selfReward: Balance,
        stakerReward: Balance,
        offlineOffenceCount: UInt16,
        slashedAmount: Balance,
        chillingCount: UInt16
    ) {
        self.era = era
        self.isActive = isActive
        self.commissionPerBillion = commissionPerBillion
        self.selfStake = selfStake
        self.totalStake = totalStake
        self.blockCount = blockCount
        self.rewardPoints = rewardPoints
        self.selfReward = selfReward
        self.stakerReward = stakerReward
        self.offlineOffenceCount = offlineOffenceCount
        self.slashedAmount = slashedAmount
        self.chillingCount = chillingCount
    }
}

extension EraValidatorReport: Codable {}
