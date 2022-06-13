public enum ParaAssignmentKind: String {
    case parathread = "Parathread"
    case parachain = "Parachain"
}

extension ParaAssignmentKind: Codable {}

/**
 Parachain or paravalidator assignment.
 */
public struct ParaCoreAssignment {
    public let coreIndex: UInt32
    public let paraId: UInt32
    public let paraAssignmentKind: ParaAssignmentKind
    public let groupIndex: UInt32
    
    public init(
        coreIndex: UInt32,
        paraId: UInt32,
        paraAssignmentKind: ParaAssignmentKind,
        groupIndex: UInt32
    ) {
        self.coreIndex = coreIndex
        self.paraId = paraId
        self.paraAssignmentKind = paraAssignmentKind
        self.groupIndex = groupIndex
    }
}

extension ParaCoreAssignment: Codable {}
