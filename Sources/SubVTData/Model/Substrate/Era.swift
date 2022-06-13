/**
 Substrate era as represented in the SubVT system.
 */
public struct Era {
    public let index: UInt
    public let startTimestamp: UInt64
    public let endTimestamp: UInt64
}

extension Era: Codable {}
