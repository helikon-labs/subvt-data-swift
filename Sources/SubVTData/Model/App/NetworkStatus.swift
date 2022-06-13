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
    
    public init(
        finalizedBlockNumber: UInt64,
        finalizedBlockHash: String,
        bestBlockNumber: UInt64,
        bestBlockHash: String,
        activeEra: Era,
        currentEpoch: Epoch,
        activeValidatorCount: Int,
        inactiveValidatorCount: Int,
        lastEraTotalReward: Balance,
        totalStake: Balance,
        returnRatePerMillion: Int,
        minStake: Balance,
        maxStake: Balance,
        averageStake: Balance,
        medianStake: Balance,
        eraRewardPoints: UInt64
    ) {
        self.finalizedBlockNumber = finalizedBlockNumber
        self.finalizedBlockHash = finalizedBlockHash
        self.bestBlockNumber = bestBlockNumber
        self.bestBlockHash = bestBlockHash
        self.activeEra = activeEra
        self.currentEpoch = currentEpoch
        self.activeValidatorCount = activeValidatorCount
        self.inactiveValidatorCount = inactiveValidatorCount
        self.lastEraTotalReward = lastEraTotalReward
        self.totalStake = totalStake
        self.returnRatePerMillion = returnRatePerMillion
        self.minStake = minStake
        self.maxStake = maxStake
        self.averageStake = averageStake
        self.medianStake = medianStake
        self.eraRewardPoints = eraRewardPoints
    }
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
    
    public init(
        finalizedBlockNumber: UInt64?,
        finalizedBlockHash: String?,
        bestBlockNumber: UInt64?,
        bestBlockHash: String?,
        activeEra: Era?,
        currentEpoch: Epoch?,
        activeValidatorCount: Int?,
        inactiveValidatorCount: Int?,
        lastEraTotalReward: Balance?,
        totalStake: Balance?,
        returnRatePerMillion: Int?,
        minStake: Balance?,
        maxStake: Balance?,
        averageStake: Balance?,
        medianStake: Balance?,
        eraRewardPoints: UInt64?
    ) {
        self.finalizedBlockNumber = finalizedBlockNumber
        self.finalizedBlockHash = finalizedBlockHash
        self.bestBlockNumber = bestBlockNumber
        self.bestBlockHash = bestBlockHash
        self.activeEra = activeEra
        self.currentEpoch = currentEpoch
        self.activeValidatorCount = activeValidatorCount
        self.inactiveValidatorCount = inactiveValidatorCount
        self.lastEraTotalReward = lastEraTotalReward
        self.totalStake = totalStake
        self.returnRatePerMillion = returnRatePerMillion
        self.minStake = minStake
        self.maxStake = maxStake
        self.averageStake = averageStake
        self.medianStake = medianStake
        self.eraRewardPoints = eraRewardPoints
    }
}

extension NetworkStatusDiff: Codable {}

public struct NetworkStatusUpdate {
    public let network: String
    public let status: NetworkStatus?
    public let diff: NetworkStatusDiff?
    
    public init(
        network: String,
        status: NetworkStatus?,
        diff: NetworkStatusDiff?
    ) {
        self.network = network
        self.status = status
        self.diff = diff
    }
}

extension NetworkStatusUpdate: Codable {}
