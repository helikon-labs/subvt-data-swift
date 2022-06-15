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
    public let networkStatusServiceHost: String?
    public let networkStatusServicePort: UInt16?
    public let reportServiceHost: String?
    public let reportServicePort: UInt16?
    public let validatorDetailsServiceHost: String?
    public let validatorDetailsServicePort: UInt16?
    public let activeValidatorListServiceHost: String?
    public let activeValidatorListServicePort: UInt16?
    public let inactiveValidatorListServiceHost: String?
    public let inactiveValidatorListServicePort: UInt16?
    
    public init(
        id: UInt64,
        hash: String,
        chain: String,
        display: String,
        ss58Prefix: UInt32,
        tokenTicker: String,
        tokenDecimalCount: UInt8,
        networkStatusServiceHost: String?,
        networkStatusServicePort: UInt16?,
        reportServiceHost: String?,
        reportServicePort: UInt16?,
        validatorDetailsServiceHost: String?,
        validatorDetailsServicePort: UInt16?,
        activeValidatorListServiceHost: String?,
        activeValidatorListServicePort: UInt16?,
        inactiveValidatorListServiceHost: String?,
        inactiveValidatorListServicePort: UInt16?
    ) {
        self.id = id
        self.hash = hash
        self.chain = chain
        self.display = display
        self.ss58Prefix = ss58Prefix
        self.tokenTicker = tokenTicker
        self.tokenDecimalCount = tokenDecimalCount
        self.networkStatusServiceHost = networkStatusServiceHost
        self.networkStatusServicePort = networkStatusServicePort
        self.reportServiceHost = reportServiceHost
        self.reportServicePort = reportServicePort
        self.validatorDetailsServiceHost = validatorDetailsServiceHost
        self.validatorDetailsServicePort = validatorDetailsServicePort
        self.activeValidatorListServiceHost = activeValidatorListServiceHost
        self.activeValidatorListServicePort = activeValidatorListServicePort
        self.inactiveValidatorListServiceHost = inactiveValidatorListServiceHost
        self.inactiveValidatorListServicePort = inactiveValidatorListServicePort
    }
}

extension Network: Codable {}
