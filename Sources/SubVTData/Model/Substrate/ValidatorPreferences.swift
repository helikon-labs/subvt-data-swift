/**
 Validate intention parameters.
 */
public struct ValidatorPreferences {
    public let commissionPerBillion: UInt64
    public let blocksNominations: Bool
}

extension ValidatorPreferences: Codable {}
