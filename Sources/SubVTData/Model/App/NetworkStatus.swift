/**
 Returned by the network status service right after the initial subscription.
 */
public struct NetworkStatus: Hashable {
    public private(set) var finalizedBlockNumber: UInt64
    public private(set) var finalizedBlockHash: String
    public private(set) var bestBlockNumber: UInt64
    public private(set) var bestBlockHash: String
    public private(set) var activeEra: Era
    public private(set) var currentEpoch: Epoch
    public private(set) var activeValidatorCount: Int
    public private(set) var inactiveValidatorCount: Int
    public private(set) var lastEraTotalReward: Balance
    public private(set) var totalStake: Balance
    public private(set) var returnRatePerMillion: Int
    public private(set) var minStake: Balance
    public private(set) var maxStake: Balance
    public private(set) var averageStake: Balance
    public private(set) var medianStake: Balance
    public private(set) var eraRewardPoints: UInt64
    
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
    public mutating func apply(diff: NetworkStatusDiff) {
        self.finalizedBlockNumber = diff.finalizedBlockNumber ?? self.finalizedBlockNumber
        self.finalizedBlockHash = diff.finalizedBlockHash ?? self.finalizedBlockHash
        self.bestBlockNumber = diff.bestBlockNumber ?? self.bestBlockNumber
        self.bestBlockHash = diff.bestBlockHash ?? self.bestBlockHash
        self.activeEra = diff.activeEra ?? self.activeEra
        self.currentEpoch = diff.currentEpoch ?? self.currentEpoch
        self.activeValidatorCount = diff.activeValidatorCount ?? self.activeValidatorCount
        self.inactiveValidatorCount = diff.inactiveValidatorCount ?? self.inactiveValidatorCount
        self.lastEraTotalReward = diff.lastEraTotalReward ?? self.lastEraTotalReward
        self.totalStake = diff.totalStake ?? self.totalStake
        self.returnRatePerMillion = diff.returnRatePerMillion ?? self.returnRatePerMillion
        self.minStake = diff.minStake ?? self.minStake
        self.maxStake = diff.maxStake ?? self.maxStake
        self.averageStake = diff.averageStake ?? self.averageStake
        self.medianStake = diff.medianStake ?? self.medianStake
        self.eraRewardPoints = diff.eraRewardPoints ?? self.eraRewardPoints
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
