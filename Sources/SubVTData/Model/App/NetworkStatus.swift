/**
 Returned by the network status service right after the initial subscription.
 */
public struct NetworkStatus: Codable {
    public let finalizedBlockNumber: UInt64
    public let finalizedBlockHash: String
    public let bestBlockNumber: UInt64
    public let bestBlockHash: String
    public let activeEra: Era
    public let currentEpoch: Epoch
    public let activeValidatorCount: Int
    public let inactiveValidatorCount: Int
    public let lastEraTotalReward: Balance
    public let totalStake: Balance
    public let returnRatePerMillion: Int
    public let minStake: Balance
    public let maxStake: Balance
    public let averageStake: Balance
    public let medianStake: Balance
    public let eraRewardPoints: UInt64
    
    private enum CodingKeys: String, CodingKey {
        case finalizedBlockNumber = "finalized_block_number"
        case finalizedBlockHash = "finalized_block_hash"
        case bestBlockNumber = "best_block_number"
        case bestBlockHash = "best_block_hash"
        case activeEra = "active_era"
        case currentEpoch = "current_epoch"
        case activeValidatorCount = "active_validator_count"
        case inactiveValidatorCount = "inactive_validator_count"
        case lastEraTotalReward = "last_era_total_reward"
        case totalStake = "total_stake"
        case returnRatePerMillion = "return_rate_per_million"
        case minStake = "min_stake"
        case maxStake = "max_stake"
        case averageStake = "average_stake"
        case medianStake = "median_stake"
        case eraRewardPoints = "era_reward_points"
    }
}

/**
 Subsequent data from the network status service, reflecting the changes
 to the previous state.
 */
public struct NetworkStatusDiff: Codable {
    public let finalizedBlockNumber: UInt64?
    public let finalizedBlockHash: String?
    public let bestBlockNumber: UInt64?
    public let bestBlockHash: String?
    public let activeEra: Era?
    public let currentEpoch: Epoch?
    public let activeValidatorCount: Int?
    public let inactiveValidatorCount: Int?
    public let lastEraTotalReward: Balance?
    public let totalStake: Balance?
    public let returnRatePerMillion: Int?
    public let minStake: Balance?
    public let maxStake: Balance?
    public let averageStake: Balance?
    public let medianStake: Balance?
    public let eraRewardPoints: UInt64?
    
    private enum CodingKeys: String, CodingKey {
        case finalizedBlockNumber = "finalized_block_number"
        case finalizedBlockHash = "finalized_block_hash"
        case bestBlockNumber = "best_block_number"
        case bestBlockHash = "best_block_hash"
        case activeEra = "active_era"
        case currentEpoch = "current_epoch"
        case activeValidatorCount = "active_validator_count"
        case inactiveValidatorCount = "inactive_validator_count"
        case lastEraTotalReward = "last_era_total_reward"
        case totalStake = "total_stake"
        case returnRatePerMillion = "return_rate_per_million"
        case minStake = "min_stake"
        case maxStake = "max_stake"
        case averageStake = "average_stake"
        case medianStake = "median_stake"
        case eraRewardPoints = "era_reward_points"
    }
}

public struct NetworkStatusUpdate: Codable {
    public let network: String
    public let status: NetworkStatus?
    public let diff: NetworkStatusDiff?
}
