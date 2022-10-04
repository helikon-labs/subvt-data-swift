import Foundation

private func getEnvValue<T>(_ json: [String: AnyObject], _ key: String) -> T {
    if let value = json[key] as? T {
        return value
    } else {
        fatalError("Cannot get value from env settings: \(key)")
    }
}

struct Settings {
    static let shared = Settings()
    let scheme: String
    let apiHost: String
    let rpcHost: String
    let networkStatusServicePort: UInt16
    let activeValidatorListServicePort: UInt16
    let inactiveValidatorListServicePort: UInt16
    let validatorDetailsServicePort: UInt16
    let reportServicePort: UInt16
    let appServicePort: UInt16
    
    private init() {
        guard let envPath = Bundle.module.path(forResource: "data-env", ofType: "json")
                ?? Bundle.main.path(forResource: "data-env", ofType: "json") else {
            fatalError("Could not find environment file.")
        }
        guard let data = try? Data(
            contentsOf: URL(fileURLWithPath: envPath),
            options: .mappedIfSafe
        ) else {
            fatalError("Could not read environment file.")
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(
            with: data,
            options: .mutableLeaves
        ) else {
            fatalError("Could not parse environment file JSON data.")
        }
        guard let json = jsonObject as? [String: AnyObject] else {
            fatalError("Could not parse environment file JSON data.")
        }
        // read data
        self.scheme = getEnvValue(json, "scheme")
        self.apiHost = getEnvValue(json, "apiHost")
        self.rpcHost = getEnvValue(json, "rpcHost")
        self.networkStatusServicePort = getEnvValue(json, "networkStatusServicePort")
        self.activeValidatorListServicePort = getEnvValue(json, "activeValidatorListServicePort")
        self.inactiveValidatorListServicePort = getEnvValue(json, "inactiveValidatorListServicePort")
        self.validatorDetailsServicePort = getEnvValue(json, "validatorDetailsServicePort")
        self.reportServicePort = getEnvValue(json, "reportServicePort")
        self.appServicePort = getEnvValue(json, "appServicePort")
    }
    
    var isUnitTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    var reportServiceURL: String {
        return "\(self.scheme)://" + apiHost + ":\(reportServicePort)"
    }
    
    var appServiceURL: String {
        return "\(self.scheme)://" + apiHost + ":\(appServicePort)"
    }
}
