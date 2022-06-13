/**
 Validate intention parameters.
 */
public struct ValidatorPreferences {
    public let commissionPerBillion: UInt64
    public let blocksNominations: Bool
    
    public init(
        commissionPerBillion: UInt64,
        blocksNominations: Bool
    ) {
        self.commissionPerBillion = commissionPerBillion
        self.blocksNominations = blocksNominations
    }
}

extension ValidatorPreferences: Codable {}
