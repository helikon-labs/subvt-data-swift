/**
 A validator represented by the active or inactive validator details service.
 */
public struct ValidatorSummary: Codable {
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
    public let isEnrolledIn1KV: Bool
    public let isParaValidator: Bool
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
    
    private enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case controllerAccountId = "controller_account_id"
        case display
        case parentDisplay = "parent_display"
        case childDisplay = "child_display"
        case confirmed
        case preferences
        case selfStake = "self_stake"
        case isActive = "is_active"
        case activeNextSession = "active_next_session"
        case inactiveNominations = "inactive_nominations"
        case oversubscribed
        case slashCount = "slash_count"
        case isEnrolledIn1KV = "is_enrolled_in_1kv"
        case isParaValidator = "is_para_validator"
        case paraId = "para_id"
        case returnRatePerBillion = "return_rate_per_billion"
        case blocksAuthored = "blocks_authored"
        case rewardPoints = "reward_points"
        case heartbeatReceived = "heartbeat_received"
        case validatorStake = "validator_stake"
    }
}

public struct ValidatorSummaryDiff: Codable {
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
    public let isEnrolledIn1KV: Bool?
    public let isParaValidator: Bool?
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
    
    private enum CodingKeys: String, CodingKey {
        case accountId = "account_id"
        case activeNextSession = "active_next_session"
        case blocksAuthored = "blocks_authored"
        case childDisplay = "child_display"
        case confirmed
        case controllerAccountId = "controller_account_id"
        case display
        case heartbeatReceived = "heartbeat_received"
        case inactiveNominations = "inactive_nominations"
        case isActive = "is_active"
        case isEnrolledIn1KV = "is_enrolled_in_1kv"
        case isParaValidator = "is_para_validator"
        case oversubscribed
        case paraId = "para_id"
        case parentDisplay = "parent_display"
        case preferences
        case returnRatePerBillion = "return_rate_per_billion"
        case rewardPoints = "reward_points"
        case selfStake = "self_stake"
        case slashCount = "slash_count"
        case validatorStake = "validator_stake"
    }
}

public struct ValidatorListUpdate: Codable {
    public let finalizedBlockNumber: UInt64?
    public let insert: [ValidatorSummary]
    public let update: [ValidatorSummaryDiff]
    public let removeIds: [String]
    
    private enum CodingKeys: String, CodingKey {
        case finalizedBlockNumber = "finalized_block_number"
        case insert
        case update
        case removeIds = "remove_ids"
    }
}
