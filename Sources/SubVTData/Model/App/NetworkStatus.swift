/**
 Returned by the network status service right after the initial subscription.
 */
public struct NetworkStatus: Hashable {
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

extension NetworkStatus {
    public func apply(diff: NetworkStatusDiff) -> NetworkStatus {
        var finalizedBlockNumber = self.finalizedBlockNumber
        if let newFinalizedBlockNumber = diff.finalizedBlockNumber {
            finalizedBlockNumber = newFinalizedBlockNumber
        }
        var finalizedBlockHash = self.finalizedBlockHash
        if let newFinalizedBlockHash = diff.finalizedBlockHash {
            finalizedBlockHash = newFinalizedBlockHash
        }
        var bestBlockNumber = self.bestBlockNumber
        if let newBestBlockNumber = diff.bestBlockNumber {
            bestBlockNumber = newBestBlockNumber
        }
        var bestBlockHash = self.bestBlockHash
        if let newBestBlockHash = diff.bestBlockHash {
            bestBlockHash = newBestBlockHash
        }
        var activeEra = self.activeEra
        if let newActiveEra = diff.activeEra {
            activeEra = newActiveEra
        }
        var currentEpoch = self.currentEpoch
        if let newCurrentEpoch = diff.currentEpoch {
            currentEpoch = newCurrentEpoch
        }
        var activeValidatorCount = self.activeValidatorCount
        if let newActiveValidatorCount = diff.activeValidatorCount {
            activeValidatorCount = newActiveValidatorCount
        }
        var inactiveValidatorCount = self.inactiveValidatorCount
        if let newInactiveValidatorCount = diff.inactiveValidatorCount {
            inactiveValidatorCount = newInactiveValidatorCount
        }
        var lastEraTotalReward = self.lastEraTotalReward
        if let newLastEraTotalReward = diff.lastEraTotalReward {
            lastEraTotalReward = newLastEraTotalReward
        }
        var totalStake = self.totalStake
        if let newTotalStake = diff.totalStake {
            totalStake = newTotalStake
        }
        var returnRatePerMillion = self.returnRatePerMillion
        if let newReturnRatePerMillion = diff.returnRatePerMillion {
            returnRatePerMillion = newReturnRatePerMillion
        }
        var minStake = self.minStake
        if let newMinStake = diff.minStake {
            minStake = newMinStake
        }
        var maxStake = self.maxStake
        if let newMaxStake = diff.maxStake {
            maxStake = newMaxStake
        }
        var averageStake = self.averageStake
        if let newAverageStake = diff.averageStake {
            averageStake = newAverageStake
        }
        var medianStake = self.medianStake
        if let newMedianStake = diff.medianStake {
            medianStake = newMedianStake
        }
        var eraRewardPoints = self.eraRewardPoints
        if let newEraRewardPoints = diff.eraRewardPoints {
            eraRewardPoints = newEraRewardPoints
        }
        return NetworkStatus(
            finalizedBlockNumber: finalizedBlockNumber,
            finalizedBlockHash: finalizedBlockHash,
            bestBlockNumber: bestBlockNumber,
            bestBlockHash: bestBlockHash,
            activeEra: activeEra,
            currentEpoch: currentEpoch,
            activeValidatorCount: activeValidatorCount,
            inactiveValidatorCount: inactiveValidatorCount,
            lastEraTotalReward: lastEraTotalReward,
            totalStake: totalStake,
            returnRatePerMillion: returnRatePerMillion,
            minStake: minStake,
            maxStake: maxStake,
            averageStake: averageStake,
            medianStake: medianStake,
            eraRewardPoints: eraRewardPoints
        )
    }
}

/**
 Subsequent data from the network status service, reflecting the changes
 to the previous state.
 */
public struct NetworkStatusDiff: Hashable {
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

public struct NetworkStatusUpdate: Hashable {
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
