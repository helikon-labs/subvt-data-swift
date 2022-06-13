/**
 Substrate epoch as represented in the SubVT system.
 */
public struct Epoch {
    public let index: UInt32
    public let startBlockNumber: UInt64
    public let startTimestamp: UInt64
    public let endTimestamp: UInt64
}

extension Epoch: Codable {}
