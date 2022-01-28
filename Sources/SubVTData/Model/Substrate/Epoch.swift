/**
 Substrate epoch as represented in the SubVT system.
 */
public struct Epoch: Codable {
    public let index: UInt32
    public let startBlockNumber: UInt64
    public let startTimestamp: UInt64
    public let endTimestamp: UInt64
    
    private enum CodingKeys: String, CodingKey {
        case index
        case startBlockNumber = "start_block_number"
        case startTimestamp = "start_timestamp"
        case endTimestamp = "end_timestamp"
    }
}
