/**
 Block summary.
 */
public struct BlockSummary: Hashable {
    public let number: UInt64
    public let hash: String
    public let timestamp: UInt64
    
    public init(
        number: UInt64,
        hash: String,
        timestamp: UInt64
    ) {
        self.number = number
        self.hash = hash
        self.timestamp = timestamp
    }
}

extension BlockSummary: Codable {}
