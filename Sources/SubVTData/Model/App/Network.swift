/**
 SubVT Substrate network model.
 */
public struct Network: Codable {
    public let id: UInt64
    public let hash: String
    public let name: String
    public let ss58Prefix: UInt32
    public let networkStatusServiceURL: String?
    public let reportServiceURL: String?
    public let validatorDetailsServiceURL: String?
    public let activeValidatorListServiceURL: String?
    public let inactiveValidatorListServiceURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case name
        case ss58Prefix
        case networkStatusServiceURL = "networkStatusServiceUrl"
        case reportServiceURL = "reportServiceUrl"
        case validatorDetailsServiceURL = "validatorDetailsServiceUrl"
        case activeValidatorListServiceURL = "activeValidatorListServiceUrl"
        case inactiveValidatorListServiceURL = "inactiveValidatorListServiceUrl"
    }
}
