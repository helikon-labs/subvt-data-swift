//
//  File.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 11.07.2022.
//

import Foundation

/// Resets the stored user in the keychain. Useful when an app gets uninstalled
/// and reinstalled. Keychain records remain in such a case, and we're assuming
/// that we need to create a new user for a new installation.
public func reset() {
    KeychainStorage.shared.resetUser()
}
