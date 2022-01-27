//
//  File.swift
//  
//
//  Created by kutsal kaan bilgin on 27.01.2022.
//

import Foundation

struct Settings {
    static let shared = Settings()
    
    var apiHost: String
    var reportServicePort: UInt16
    
    var isUnitTesting: Bool {
        return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    private init() {
        guard let envPath = Bundle.module.path(forResource: "env", ofType: "json") else {
            fatalError("Could not find environment file.")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: envPath), options: .mappedIfSafe) else {
            fatalError("Could not read environment file.")
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
            fatalError("Could not parse environment file JSON data.")
        }
        guard let json = jsonObject as? [String: AnyObject] else {
            fatalError("Could not parse environment file JSON data.")
        }
        if let apiHost = json["apiHost"] as? String, !apiHost.isEmpty {
            self.apiHost = apiHost
        } else {
            fatalError("API host address not found in the environment file.")
        }
        if let reportServicePort = json["reportServicePort"] as? UInt16, reportServicePort > 0 {
            self.reportServicePort = reportServicePort
        } else {
            fatalError("Report service port not found in the environment file.")
        }
    }
}
