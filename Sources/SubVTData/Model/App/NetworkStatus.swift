/**
 Returned by the network status service right after the initial subscription.
 */
public struct NetworkStatus: Codable {
    let finalizedBlockNumber: UInt64
    let finalizedBlockHash: String
    let bestBlockNumber: UInt64
    let bestBlockHash: String
    let activeEra: Era
    let currentEpoch: Epoch
    let activeValidatorCount: Int
    let inactiveValidatorCount: Int
    let lastEraTotalReward: Balance
    let totalStake: Balance
    let returnRatePerMillion: Int
    let minStake: Balance
    let maxStake: Balance
    let averageStake: Balance
    let medianStake: Balance
    let eraRewardPoints: UInt64
    
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
    let finalizedBlockNumber: UInt64?
    let finalizedBlockHash: String?
    let bestBlockNumber: UInt64?
    let bestBlockHash: String?
    let activeEra: Era?
    let currentEpoch: Epoch?
    let activeValidatorCount: Int?
    let inactiveValidatorCount: Int?
    let lastEraTotalReward: Balance?
    let totalStake: Balance?
    let returnRatePerMillion: Int?
    let minStake: Balance?
    let maxStake: Balance?
    let averageStake: Balance?
    let medianStake: Balance?
    let eraRewardPoints: UInt64?
    
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
    let network: String
    let status: NetworkStatus?
    let diff: NetworkStatusDiff?
}
