/**
 A validator represented by the active or inactive validator details service.
 */
public struct ValidatorSummary: Codable, Hashable {
    public let accountId: AccountId
    public let address: String
    public private(set) var controllerAccountId: AccountId?
    public private(set) var networkId: UInt64
    public private(set) var display: String?
    public private(set) var parentDisplay: String?
    public private(set) var childDisplay: String?
    public private(set) var confirmed: Bool
    public private(set) var preferences: ValidatorPreferences
    public private(set) var selfStake: StakeSummary
    public private(set) var isActive: Bool
    public private(set) var isActiveNextSession: Bool
    public private(set) var inactiveNominations: InactiveNominationsSummary
    public private(set) var oversubscribed: Bool
    public private(set) var slashCount: Int
    public private(set) var isEnrolledIn1Kv: Bool
    public private(set) var isParaValidator: Bool
    public private(set) var paraId: Int?
    public private(set) var returnRatePerBillion: UInt64?
    public private(set) var blocksAuthored: Int?
    public private(set) var rewardPoints: UInt64?
    public private(set) var heartbeatReceived: Bool?
    public private(set) var validatorStake: ValidatorStakeSummary?
    
    public init(
        accountId: AccountId,
        address: String,
        controllerAccountId: AccountId?,
        networkId: UInt64,
        display: String?,
        parentDisplay: String?,
        childDisplay: String?,
        confirmed: Bool,
        preferences: ValidatorPreferences,
        selfStake: StakeSummary,
        isActive: Bool,
        isActiveNextSession: Bool,
        inactiveNominations: InactiveNominationsSummary,
        oversubscribed: Bool,
        slashCount: Int,
        isEnrolledIn1Kv: Bool,
        isParaValidator: Bool,
        paraId: Int?,
        returnRatePerBillion: UInt64?,
        blocksAuthored: Int?,
        rewardPoints: UInt64?,
        heartbeatReceived: Bool?,
        validatorStake: ValidatorStakeSummary?
    ) {
        self.accountId = accountId
        self.address = address
        self.controllerAccountId = controllerAccountId
        self.networkId = networkId
        self.display = display
        self.parentDisplay = parentDisplay
        self.childDisplay = childDisplay
        self.confirmed = confirmed
        self.preferences = preferences
        self.selfStake = selfStake
        self.isActive = isActive
        self.isActiveNextSession = isActiveNextSession
        self.inactiveNominations = inactiveNominations
        self.oversubscribed = oversubscribed
        self.slashCount = slashCount
        self.isEnrolledIn1Kv = isEnrolledIn1Kv
        self.isParaValidator = isParaValidator
        self.paraId = paraId
        self.returnRatePerBillion = returnRatePerBillion
        self.blocksAuthored = blocksAuthored
        self.rewardPoints = rewardPoints
        self.heartbeatReceived = heartbeatReceived
        self.validatorStake = validatorStake
    }
}

extension ValidatorSummary {
    public mutating func apply(diff: ValidatorSummaryDiff) {
        self.controllerAccountId = diff.controllerAccountId ?? self.controllerAccountId
        self.networkId = diff.networkId ?? self.networkId
        self.display = diff.display ?? self.display
        self.parentDisplay = diff.parentDisplay ?? self.parentDisplay
        self.childDisplay = diff.childDisplay ?? self.childDisplay
        self.confirmed = diff.confirmed ?? self.confirmed
        self.preferences = diff.preferences ?? self.preferences
        self.selfStake = diff.selfStake ?? self.selfStake
        self.isActive = diff.isActive ?? self.isActive
        self.isActiveNextSession = diff.isActiveNextSession ?? self.isActiveNextSession
        self.inactiveNominations = diff.inactiveNominations ?? self.inactiveNominations
        self.oversubscribed = diff.oversubscribed ?? self.oversubscribed
        self.slashCount = diff.slashCount ?? self.slashCount
        self.isEnrolledIn1Kv = diff.isEnrolledIn1Kv ?? self.isEnrolledIn1Kv
        self.isParaValidator = diff.isParaValidator ?? self.isParaValidator
        self.paraId = diff.paraId ?? self.paraId
        self.returnRatePerBillion = diff.returnRatePerBillion ?? self.returnRatePerBillion
        self.blocksAuthored = diff.blocksAuthored ?? self.blocksAuthored
        self.rewardPoints = diff.rewardPoints ?? self.rewardPoints
        self.heartbeatReceived = diff.heartbeatReceived ?? self.heartbeatReceived
        self.validatorStake = diff.validatorStake ?? self.validatorStake
    }
}

public struct ValidatorSummaryDiff: Codable, Hashable {
    public let accountId: AccountId
    public let controllerAccountId: AccountId?
    public let networkId: UInt64?
    public let display: String?
    public let parentDisplay: String?
    public let childDisplay: String?
    public let confirmed: Bool?
    public let preferences: ValidatorPreferences?
    public let selfStake: StakeSummary?
    public let isActive: Bool?
    public let isActiveNextSession: Bool?
    public let inactiveNominations: InactiveNominationsSummary?
    public let oversubscribed: Bool?
    public let slashCount: Int?
    public let isEnrolledIn1Kv: Bool?
    public let isParaValidator: Bool?
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
}

public struct ValidatorListUpdate: Codable, Hashable {
    public let finalizedBlockNumber: UInt64?
    public let insert: [ValidatorSummary]
    public let update: [ValidatorSummaryDiff]
    public let removeIds: [String]
    
    public init(
        finalizedBlockNumber: UInt64?,
        insert: [ValidatorSummary],
        update: [ValidatorSummaryDiff],
        removeIds: [String]
    ) {
        self.finalizedBlockNumber = finalizedBlockNumber
        self.insert = insert
        self.update = update
        self.removeIds = removeIds
    }
}
