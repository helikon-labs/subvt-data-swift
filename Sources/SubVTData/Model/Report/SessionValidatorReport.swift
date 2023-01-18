/**
 Report for a single session-validator.
 */
public struct SessionValidatorReport: Hashable {
    public let session: Epoch
    public let isActive: Bool
    public let validatorIndex: UInt64?
    public let heartbeatEvent: HeartbeatEvent?
    public let blocksAuthored: [BlockSummary]?
    public let paraValidatorGroupIndex: UInt64?
    public let paraValidatorIndex: UInt64?
    public let paraVotesSummary: ParaVotesSummary?
    
    public init(
        session: Epoch,
        isActive: Bool,
        validatorIndex: UInt64?,
        heartbeatEvent: HeartbeatEvent?,
        blocksAuthored: [BlockSummary]?,
        paraValidatorGroupIndex: UInt64?,
        paraValidatorIndex: UInt64?,
        paraVotesSummary: ParaVotesSummary?
    ) {
        self.session = session
        self.isActive = isActive
        self.validatorIndex = validatorIndex
        self.heartbeatEvent = heartbeatEvent
        self.blocksAuthored = blocksAuthored
        self.paraValidatorGroupIndex = paraValidatorGroupIndex
        self.paraValidatorIndex = paraValidatorIndex
        self.paraVotesSummary = paraVotesSummary
    }
}

extension SessionValidatorReport: Codable {}
