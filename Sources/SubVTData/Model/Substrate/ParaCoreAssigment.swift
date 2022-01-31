public enum ParaAssignmentKind: String, Codable {
    case parathread = "Parathread"
    case parachain = "Parachain"
}

/**
 Parachain or paravalidator assignment.
 */
public struct ParaCoreAssignment: Codable {
    public let coreIndex: UInt32
    public let paraId: UInt32
    public let paraAssignmentKind: ParaAssignmentKind
    public let groupIndex: UInt32
    
    private enum CodingKeys: String, CodingKey {
        case coreIndex = "coreIndex"
        case paraId = "para_id"
        case paraAssignmentKind = "para_assignment_kind"
        case groupIndex = "group_index"
    }
}
