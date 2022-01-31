/**
 Validate intention parameters.
 */
public struct ValidatorPreferences: Codable {
    public let commissionPerBillion: UInt64
    public let blocksNominations: Bool
    
    private enum CodingKeys: String, CodingKey {
        case commissionPerBillion = "commission_per_billion"
        case blocksNominations = "blocks_nominations"
    }
}
