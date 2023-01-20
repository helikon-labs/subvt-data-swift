/**
 Substrate era as represented in the SubVT system.
 */
public struct Era: Hashable {
    public let index: UInt32
    public let startTimestamp: UInt64
    public let endTimestamp: UInt64
    
    public init() {
        self.index = 0
        self.startTimestamp = 0
        self.endTimestamp = 0
    }
    
    public init(
        index: UInt32,
        startTimestamp: UInt64,
        endTimestamp: UInt64
    ) {
        self.index = index
        self.startTimestamp = startTimestamp
        self.endTimestamp = endTimestamp
    }
}

extension Era: Codable {}
