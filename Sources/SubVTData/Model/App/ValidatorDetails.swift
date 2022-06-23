/**
 Returned by the validatod details service right after the initial subscription.
 */
public struct ValidatorDetails: Hashable {
    public let account: Account
    public let controllerAccountId: AccountId
    public let preferences: ValidatorPreferences
    public let selfStake: Stake
    public let rewardDestination: RewardDestination
    public let nextSessionKeys: String
    public let isActive: Bool
    public let activeNextSession: Bool
    public let nominations: [Nomination]
    public let oversubscribed: Bool
    public let activeEraCount: UInt32
    public let inactiveEraCount: UInt32
    public let slashCount: UInt32
    public let offlineOffenceCount: UInt32
    public let unclaimedEraIndices: [UInt32]
    public let isParaValidator: Bool
    public let paraCoreAssignment: ParaCoreAssignment?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: UInt32?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStake?
    public let onekvCandidateRecordId: UInt64?
    public let onekvBinaryVersion: String?
    public let onekvRank: UInt32?
    public let onekvLocation: String?
    public let onekvIsValid: Bool?
    public let onekvOnlineSince: UInt64?
    public let onekvOfflineSince: UInt64?
    
    public init(
        account: Account,
        controllerAccountId: AccountId,
        preferences: ValidatorPreferences,
        selfStake: Stake,
        rewardDestination: RewardDestination,
        nextSessionKeys: String,
        isActive: Bool,
        activeNextSession: Bool,
        nominations: [Nomination],
        oversubscribed: Bool,
        activeEraCount: UInt32,
        inactiveEraCount: UInt32,
        slashCount: UInt32,
        offlineOffenceCount: UInt32,
        unclaimedEraIndices: [UInt32],
        isParaValidator: Bool,
        paraCoreAssignment: ParaCoreAssignment?,
        returnRatePerBillion: UInt64?,
        blocksAuthored: UInt32?,
        rewardPoints: UInt64?,
        heartbeatReceived: Bool?,
        validatorStake: ValidatorStake?,
        onekvCandidateRecordId: UInt64?,
        onekvBinaryVersion: String?,
        onekvRank: UInt32?,
        onekvLocation: String?,
        onekvIsValid: Bool?,
        onekvOnlineSince: UInt64?,
        onekvOfflineSince: UInt64?
    ) {
        self.account = account
        self.controllerAccountId = controllerAccountId
        self.preferences = preferences
        self.selfStake = selfStake
        self.rewardDestination = rewardDestination
        self.nextSessionKeys = nextSessionKeys
        self.isActive = isActive
        self.activeNextSession = activeNextSession
        self.nominations = nominations
        self.oversubscribed = oversubscribed
        self.activeEraCount = activeEraCount
        self.inactiveEraCount = inactiveEraCount
        self.slashCount = slashCount
        self.offlineOffenceCount = offlineOffenceCount
        self.unclaimedEraIndices = unclaimedEraIndices
        self.isParaValidator = isParaValidator
        self.paraCoreAssignment = paraCoreAssignment
        self.returnRatePerBillion = returnRatePerBillion
        self.blocksAuthored = blocksAuthored
        self.rewardPoints = rewardPoints
        self.heartbeatReceived = heartbeatReceived
        self.validatorStake = validatorStake
        self.onekvCandidateRecordId = onekvCandidateRecordId
        self.onekvBinaryVersion = onekvBinaryVersion
        self.onekvRank = onekvRank
        self.onekvLocation = onekvLocation
        self.onekvIsValid = onekvIsValid
        self.onekvOnlineSince = onekvOnlineSince
        self.onekvOfflineSince = onekvOfflineSince
    }
}

extension ValidatorDetails: Codable {}

/**
 Subsequent data from the validator details service, reflecting the changes
 to the previous state.
 */
public struct ValidatorDetailsDiff: Hashable {
    public let account: Account
    public let controllerAccountId: AccountId?
    public let preferences: ValidatorPreferences?
    public let selfStake: Stake?
    public let rewardDestination: RewardDestination?
    public let nextSessionKeys: String?
    public let isActive: Bool?
    public let activeNextSession: Bool?
    public let nominations: [Nomination]?
    public let oversubscribed: Bool?
    public let activeEraCount: UInt32?
    public let inactiveEraCount: UInt32?
    public let slashCount: UInt32?
    public let offlineOffenceCount: UInt32?
    public let unclaimedEraIndices: [UInt32]?
    public let isParaValidator: Bool?
    public let paraCoreAssignment: ParaCoreAssignment?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: UInt32?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStake?
    public let onekvCandidateRecordId: UInt64?
    public let onekvBinaryVersion: String?
    public let onekvRank: UInt32?
    public let onekvLocation: String?
    public let onekvIsValid: Bool?
    public let onekvOnlineSince: UInt64?
    public let onekvOfflineSince: UInt64?
}

extension ValidatorDetailsDiff: Codable {}

public struct ValidatorDetailsUpdate {
    public let finalizedBlockNumber: UInt64?
    public let validatorDetails: ValidatorDetails?
    public let validatorDetailsUpdate: ValidatorDetailsDiff?
    
    public init(
        finalizedBlockNumber: UInt64?,
        validatorDetails: ValidatorDetails?,
        validatorDetailsUpdate: ValidatorDetailsDiff?
    ) {
        self.finalizedBlockNumber = finalizedBlockNumber
        self.validatorDetails = validatorDetails
        self.validatorDetailsUpdate = validatorDetailsUpdate
    }
}

extension ValidatorDetailsUpdate: Codable {}
