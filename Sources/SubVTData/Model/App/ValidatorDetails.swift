/**
 Returned by the validator details service right after the initial subscription.
 */
public struct ValidatorDetails: Hashable {
    public private(set) var account: Account
    public private(set) var controllerAccountId: AccountId
    public private(set) var networkId: UInt64
    public private(set) var preferences: ValidatorPreferences
    public private(set) var selfStake: Stake
    public private(set) var rewardDestination: RewardDestination
    public private(set) var nextSessionKeys: String
    public private(set) var isActive: Bool
    public private(set) var isActiveNextSession: Bool
    public private(set) var nominations: [Nomination]
    public private(set) var oversubscribed: Bool
    public private(set) var activeEraCount: UInt32
    public private(set) var inactiveEraCount: UInt32
    public private(set) var slashCount: UInt32
    public private(set) var offlineOffenceCount: UInt32
    public private(set) var unclaimedEraIndices: [UInt32]
    public private(set) var isParaValidator: Bool
    public private(set) var paraCoreAssignment: ParaCoreAssignment?
    public private(set) var returnRatePerBillion: UInt64?
    public private(set) var blocksAuthored: UInt32?
    public private(set) var rewardPoints: UInt64?
    public private(set) var heartbeatReceived: Bool?
    public private(set) var validatorStake: ValidatorStake?
    public private(set) var onekvCandidateRecordId: UInt64?
    public private(set) var onekvRank: UInt32?
    public private(set) var onekvLocation: String?
    public private(set) var onekvIsValid: Bool?
    public private(set) var onekvOfflineSince: UInt64?
    
    public init(
        account: Account,
        controllerAccountId: AccountId,
        networkId: UInt64,
        preferences: ValidatorPreferences,
        selfStake: Stake,
        rewardDestination: RewardDestination,
        nextSessionKeys: String,
        isActive: Bool,
        isActiveNextSession: Bool,
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
        onekvRank: UInt32?,
        onekvLocation: String?,
        onekvIsValid: Bool?,
        onekvOfflineSince: UInt64?
    ) {
        self.account = account
        self.controllerAccountId = controllerAccountId
        self.networkId = networkId
        self.preferences = preferences
        self.selfStake = selfStake
        self.rewardDestination = rewardDestination
        self.nextSessionKeys = nextSessionKeys
        self.isActive = isActive
        self.isActiveNextSession = isActiveNextSession
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
        self.onekvRank = onekvRank
        self.onekvLocation = onekvLocation
        self.onekvIsValid = onekvIsValid
        self.onekvOfflineSince = onekvOfflineSince
    }
    
    public var nominationTotal: Balance {
        return self.nominations
            .map { $0.stake.activeAmount }
            .reduce(Balance(integerLiteral: 0)) { $0 + $1 }
    }
    
    public var inactiveNominations: [Nomination] {
        guard let activeStake = self.validatorStake else {
            return self.nominations
        }
        return self.nominations
            .filter { nomination in
                activeStake.nominators.firstIndex { nominatorStake in
                    nominatorStake.account.id == nomination.stashAccount.id
                } == nil
            }
    }
    
    public var inactiveNominationTotal: Balance {
        return self.inactiveNominations
            .map { $0.stake.activeAmount }
            .reduce(Balance(integerLiteral: 0)) { $0 + $1 }
    }
}

extension ValidatorDetails: Codable {}

extension ValidatorDetails {
    public mutating func apply(diff: ValidatorDetailsDiff) {
        self.account = diff.account
        self.controllerAccountId = diff.controllerAccountId ?? self.controllerAccountId
        self.networkId = diff.networkId ?? self.networkId
        self.preferences = diff.preferences ?? self.preferences
        self.selfStake = diff.selfStake ?? self.selfStake
        self.rewardDestination = diff.rewardDestination ?? self.rewardDestination
        self.nextSessionKeys = diff.nextSessionKeys ?? self.nextSessionKeys
        self.isActive = diff.isActive ?? self.isActive
        self.isActiveNextSession = diff.isActiveNextSession ?? self.isActiveNextSession
        self.nominations = diff.nominations ?? self.nominations
        self.oversubscribed = diff.oversubscribed ?? self.oversubscribed
        self.activeEraCount = diff.activeEraCount ?? self.activeEraCount
        self.inactiveEraCount = diff.inactiveEraCount ?? self.inactiveEraCount
        self.slashCount = diff.slashCount ?? self.slashCount
        self.offlineOffenceCount = diff.offlineOffenceCount ?? self.offlineOffenceCount
        self.unclaimedEraIndices = diff.unclaimedEraIndices ?? self.unclaimedEraIndices
        self.isParaValidator = diff.isParaValidator ?? self.isParaValidator
        self.paraCoreAssignment = diff.paraCoreAssignment ?? self.paraCoreAssignment
        self.returnRatePerBillion = diff.returnRatePerBillion ?? self.returnRatePerBillion
        self.blocksAuthored = diff.blocksAuthored ?? self.blocksAuthored
        self.rewardPoints = diff.rewardPoints ?? self.rewardPoints
        self.heartbeatReceived = diff.heartbeatReceived ?? self.heartbeatReceived
        self.validatorStake = diff.validatorStake ?? self.validatorStake
        self.onekvCandidateRecordId = diff.onekvCandidateRecordId ?? self.onekvCandidateRecordId
        self.onekvRank = diff.onekvRank ?? self.onekvRank
        self.onekvLocation = diff.onekvLocation ?? self.onekvLocation
        self.onekvIsValid = diff.onekvIsValid ?? self.onekvIsValid
        self.onekvOfflineSince = diff.onekvOfflineSince ?? self.onekvOfflineSince
    }
}

/**
 Subsequent data from the validator details service, reflecting the changes
 to the previous state.
 */
public struct ValidatorDetailsDiff: Hashable {
    public let account: Account
    public let controllerAccountId: AccountId?
    public let networkId: UInt64?
    public let preferences: ValidatorPreferences?
    public let selfStake: Stake?
    public let rewardDestination: RewardDestination?
    public let nextSessionKeys: String?
    public let isActive: Bool?
    public let isActiveNextSession: Bool?
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
    public let onekvRank: UInt32?
    public let onekvLocation: String?
    public let onekvIsValid: Bool?
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
