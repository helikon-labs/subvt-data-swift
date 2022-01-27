//
//  File.swift
//  
//
//  Created by kutsal kaan bilgin on 27.01.2022.
//

import Foundation

struct Settings {
    static let shared = Settings()
    let apiHost: String
    let networkStatusServicePort: UInt16
    let activeValidatorListServicePort: UInt16
    let inactiveValidatorListServicePort: UInt16
    let validatorDetailsServicePort: UInt16
    let reportServicePort: UInt16
    let appServicePort: UInt16
    
    private init() {
        guard let envPath = Bundle.module.path(forResource: "env", ofType: "json") else {
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
        if let apiHost = json["apiHost"] as? String, !apiHost.isEmpty {
            self.apiHost = apiHost
        } else {
            fatalError("API host address not found in the environment file.")
        }
        if let networkStatusServicePort = json["networkStatusServicePort"] as? UInt16,
           networkStatusServicePort > 0 {
            self.networkStatusServicePort = networkStatusServicePort
        } else {
            fatalError("Network status service port not found in the environment file.")
        }
        if let activeValidatorListServicePort = json["activeValidatorListServicePort"] as? UInt16,
           activeValidatorListServicePort > 0 {
            self.activeValidatorListServicePort = activeValidatorListServicePort
        } else {
            fatalError("Active validator list service port not found in the environment file.")
        }
        if let inactiveValidatorListServicePort = json["inactiveValidatorListServicePort"] as? UInt16,
           inactiveValidatorListServicePort > 0 {
            self.inactiveValidatorListServicePort = inactiveValidatorListServicePort
        } else {
            fatalError("Inactive validator list service port not found in the environment file.")
        }
        if let validatorDetailsServicePort = json["validatorDetailsServicePort"] as? UInt16,
           validatorDetailsServicePort > 0 {
            self.validatorDetailsServicePort = validatorDetailsServicePort
        } else {
            fatalError("Validator details service port not found in the environment file.")
        }
        if let reportServicePort = json["reportServicePort"] as? UInt16,
           reportServicePort > 0 {
            self.reportServicePort = reportServicePort
        } else {
            fatalError("Report service port not found in the environment file.")
        }
        if let appServicePort = json["appServicePort"] as? UInt16,
           appServicePort > 0 {
            self.appServicePort = appServicePort
        } else {
            fatalError("App service port not found in the environment file.")
        }
    }
    
    var isUnitTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    var reportServiceURL: String {
        return "http://" + apiHost + ":\(reportServicePort)"
    }
    
    var appServiceURL: String {
        return "http://" + apiHost + ":\(appServicePort)"
    }
}
