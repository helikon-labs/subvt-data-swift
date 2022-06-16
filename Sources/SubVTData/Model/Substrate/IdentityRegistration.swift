/**
 Account identity (can be non-existent for an account).
 */
public struct IdentityRegistration: Hashable {
    public let display: String?
    public let email: String?
    public let riot: String?
    public let twitter: String?
    public let web: String?
    public let confirmed: Bool
    
    public init(
        display: String?,
        email: String?,
        riot: String?,
        twitter: String?,
        web: String?,
        confirmed: Bool
    ) {
        self.display = display
        self.email = email
        self.riot = riot
        self.twitter = twitter
        self.web = web
        self.confirmed = confirmed
    }
}

extension IdentityRegistration: Codable {}
