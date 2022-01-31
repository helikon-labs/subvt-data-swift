/**
 Validate intention parameters.
 */
public struct ValidatorPreferences: Codable {
    public let commissionPerBillion: UInt64
    public let blocksNominations: Bool
}
