/**
 Session/era para validation votes summary..
 */
public struct ParaVotesSummary: Hashable {
    public let explicit: UInt32
    public let implicit: UInt32
    public let missed: UInt32
    
    public init(
        explicit: UInt32,
        implicit: UInt32,
        missed: UInt32
    ) {
        self.explicit = explicit
        self.implicit = implicit
        self.missed = missed
    }
}

extension ParaVotesSummary: Codable {}
