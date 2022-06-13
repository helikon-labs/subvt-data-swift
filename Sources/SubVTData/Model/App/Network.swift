/**
 SubVT Substrate network model.
 */
public struct Network {
    public let id: UInt64
    public let hash: String
    public let chain: String
    public let display: String
    public let ss58Prefix: UInt32
    public let tokenTicker: String
    public let tokenDecimalCount: UInt8
    public let networkStatusServiceURL: String?
    public let reportServiceURL: String?
    public let validatorDetailsServiceURL: String?
    public let activeValidatorListServiceURL: String?
    public let inactiveValidatorListServiceURL: String?
}

extension Network: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case hash
        case chain
        case display
        case ss58Prefix
        case tokenTicker
        case tokenDecimalCount
        case networkStatusServiceURL = "networkStatusServiceUrl"
        case reportServiceURL = "reportServiceUrl"
        case validatorDetailsServiceURL = "validatorDetailsServiceUrl"
        case activeValidatorListServiceURL = "activeValidatorListServiceUrl"
        case inactiveValidatorListServiceURL = "inactiveValidatorListServiceUrl"
    }
}
