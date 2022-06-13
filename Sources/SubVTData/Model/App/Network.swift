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
    
    public init(
        id: UInt64,
        hash: String,
        chain: String,
        display: String,
        ss58Prefix: UInt32,
        tokenTicker: String,
        tokenDecimalCount: UInt8,
        networkStatusServiceURL: String?,
        reportServiceURL: String?,
        validatorDetailsServiceURL: String?,
        activeValidatorListServiceURL: String?,
        inactiveValidatorListServiceURL: String?
    ) {
        self.id = id
        self.hash = hash
        self.chain = chain
        self.display = display
        self.ss58Prefix = ss58Prefix
        self.tokenTicker = tokenTicker
        self.tokenDecimalCount = tokenDecimalCount
        self.networkStatusServiceURL = networkStatusServiceURL
        self.reportServiceURL = reportServiceURL
        self.validatorDetailsServiceURL = validatorDetailsServiceURL
        self.activeValidatorListServiceURL = activeValidatorListServiceURL
        self.inactiveValidatorListServiceURL = inactiveValidatorListServiceURL
    }
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
