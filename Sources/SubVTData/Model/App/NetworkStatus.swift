/**
 Returned by the network status service right after the initial subscription.
 */
public struct NetworkStatus {
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
}

extension NetworkStatus: Codable {}

/**
 Subsequent data from the network status service, reflecting the changes
 to the previous state.
 */
public struct NetworkStatusDiff {
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
}

extension NetworkStatusDiff: Codable {}

public struct NetworkStatusUpdate {
    public let network: String
    public let status: NetworkStatus?
    public let diff: NetworkStatusDiff?
}

extension NetworkStatusUpdate: Codable {}
