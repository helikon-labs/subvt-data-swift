/**
 Substrate epoch as represented in the SubVT system.
 */
public struct Epoch: Hashable {
    public let index: UInt32
    public let startBlockNumber: UInt64
    public let startTimestamp: UInt64
    public let endTimestamp: UInt64
    
    public init(
        index: UInt32,
        startBlockNumber: UInt64,
        startTimestamp: UInt64,
        endTimestamp: UInt64
    ) {
        self.index = index
        self.startBlockNumber = startBlockNumber
        self.startTimestamp = startTimestamp
        self.endTimestamp = endTimestamp
    }
}

extension Epoch: Codable {}
