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
        case ss58Prefix = "ss58_prefix"
        case networkStatusServiceURL = "network_status_service_url"
        case reportServiceURL = "report_service_url"
        case validatorDetailsServiceURL = "validator_details_service_url"
        case activeValidatorListServiceURL = "active_validator_list_service_url"
        case inactiveValidatorListServiceURL = "inactive_validator_list_service_url"
    }
}
