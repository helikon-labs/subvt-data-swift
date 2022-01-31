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
    public let totalRewardPoints: UInt64
    public let unclaimedEraIndices: [UInt32]
    public let isParaValidator: Bool
    public let paraCoreAssignment: ParaCoreAssignment?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: UInt32?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStake?
    public let onekvCandidateRecordId: UInt64?
    public let onekvRank: UInt32?
    public let onekvIsValid: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case account
        case controllerAccountId = "controller_account_id"
        case preferences
        case selfStake = "self_stake"
        case rewardDestination = "reward_destination"
        case nextSessionKeys = "next_session_keys"
        case isActive = "is_active"
        case activeNextSession = "active_next_session"
        case nominations
        case oversubscribed
        case activeEraCount = "active_era_count"
        case inactiveEraCount = "inactive_era_count"
        case slashCount = "slash_count"
        case offlineOffenceCount = "offline_offence_count"
        case totalRewardPoints = "total_reward_points"
        case unclaimedEraIndices = "unclaimed_era_indices"
        case isParaValidator = "is_para_validator"
        case paraCoreAssignment = "para_core_assignment"
        case returnRatePerBillion = "return_rate_per_billion"
        case blocksAuthored = "blocks_authored"
        case rewardPoints = "reward_points"
        case heartbeatReceived = "heartbeat_received"
        case validatorStake = "validator_stake"
        case onekvCandidateRecordId = "onekv_candidate_record_id"
        case onekvRank = "onekv_rank"
        case onekvIsValid = "onekv_is_valid"
    }
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
    public let totalRewardPoints: UInt64?
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
    public let onekvIsValid: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case account
        case activeEraCount = "active_era_count"
        case activeNextSession = "active_next_session"
        case blocksAuthored = "blocks_authored"
        case controllerAccountId = "controller_account_id"
        case heartbeatReceived = "heartbeat_received"
        case inactiveEraCount = "inactive_era_count"
        case isActive = "is_active"
        case isParaValidator = "is_para_validator"
        case nextSessionKeys = "next_session_keys"
        case nominations
        case offlineOffenceCount = "offline_offence_count"
        case onekvCandidateRecordId = "onekv_candidate_record_id"
        case onekvIsValid = "onekv_is_valid"
        case onekvRank = "onekv_rank"
        case oversubscribed
        case paraCoreAssignment = "para_core_assignment"
        case preferences
        case returnRatePerBillion = "return_rate_per_billion"
        case rewardDestination = "reward_destination"
        case rewardPoints = "reward_points"
        case selfStake = "self_stake"
        case slashCount = "slash_count"
        case totalRewardPoints = "total_reward_points"
        case unclaimedEraIndices = "unclaimed_era_indices"
        case validatorStake = "validator_stake"
    }
}

public struct ValidatorDetailsUpdate: Codable {
    public let finalizedBlockNumber: UInt64?
    public let validatorDetails: ValidatorDetails?
    public let validatorDetailsUpdate: ValidatorDetailsDiff?
    
    private enum CodingKeys: String, CodingKey {
        case finalizedBlockNumber = "finalized_block_number"
        case validatorDetails = "validator_details"
        case validatorDetailsUpdate = "validator_details_update"
    }
}
