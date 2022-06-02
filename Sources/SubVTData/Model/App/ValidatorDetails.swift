/**
 Returned by the validatod details service right after the initial subscription.
 */
public struct ValidatorDetails: Codable {
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
}

/**
 Subsequent data from the validator details service, reflecting the changes
 to the previous state.
 */
public struct ValidatorDetailsDiff: Codable {
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

public struct ValidatorDetailsUpdate: Codable {
    public let finalizedBlockNumber: UInt64?
    public let validatorDetails: ValidatorDetails?
    public let validatorDetailsUpdate: ValidatorDetailsDiff?
}
