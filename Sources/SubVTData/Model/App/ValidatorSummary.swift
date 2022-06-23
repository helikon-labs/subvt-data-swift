/**
 A validator represented by the active or inactive validator details service.
 */
public struct ValidatorSummary: Codable, Hashable {
    public let accountId: AccountId
    public let controllerAccountId: AccountId?
    public let display: String?
    public let parentDisplay: String?
    public let childDisplay: String?
    public let confirmed: Bool
    public let preferences: ValidatorPreferences
    public let selfStake: StakeSummary
    public let isActive: Bool
    public let activeNextSession: Bool
    public let inactiveNominations: InactiveNominationsSummary
    public let oversubscribed: Bool
    public let slashCount: Int
    public let isEnrolledIn1Kv: Bool
    public let isParaValidator: Bool
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
    
    public init(
        accountId: AccountId,
        controllerAccountId: AccountId?,
        display: String?,
        parentDisplay: String?,
        childDisplay: String?,
        confirmed: Bool,
        preferences: ValidatorPreferences,
        selfStake: StakeSummary,
        isActive: Bool,
        activeNextSession: Bool,
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
        self.controllerAccountId = controllerAccountId
        self.display = display
        self.parentDisplay = parentDisplay
        self.childDisplay = childDisplay
        self.confirmed = confirmed
        self.preferences = preferences
        self.selfStake = selfStake
        self.isActive = isActive
        self.activeNextSession = activeNextSession
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

public struct ValidatorSummaryDiff: Codable, Hashable {
    public let accountId: AccountId
    public let controllerAccountId: AccountId?
    public let display: String?
    public let parentDisplay: String?
    public let childDisplay: String?
    public let confirmed: Bool?
    public let preferences: ValidatorPreferences?
    public let selfStake: StakeSummary?
    public let isActive: Bool?
    public let activeNextSession: Bool?
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
