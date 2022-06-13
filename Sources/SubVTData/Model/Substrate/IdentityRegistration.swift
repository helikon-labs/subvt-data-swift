/**
 Account identity (can be non-existent for an account).
 */
public struct IdentityRegistration {
    public let display: String?
    public let email: String?
    public let riot: String?
    public let twitter: String?
    public let web: String?
    public let confirmed: Bool
}

extension IdentityRegistration: Codable {}
