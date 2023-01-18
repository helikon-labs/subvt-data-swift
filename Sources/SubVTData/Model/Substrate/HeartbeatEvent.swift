/**
 Imonline heartbeat event.
 */
public struct HeartbeatEvent: Hashable {
    public let block: BlockSummary
    public let eventIndex: UInt32
    public let imOnlineKey: String
    
    public init(
        block: BlockSummary,
        eventIndex: UInt32,
        imOnlineKey: String
    ) {
        self.block = block
        self.eventIndex = eventIndex
        self.imOnlineKey = imOnlineKey
    }
}

extension HeartbeatEvent: Codable {}
