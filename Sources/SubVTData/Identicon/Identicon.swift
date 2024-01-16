//
//  Identicon.swift
//  
//
//  Created by Kutsal Kaan Bilgin on 29.07.2022.
//
//  Mainly adopted from the Nova Wallet Substrate SDK.
//  https://github.com/nova-wallet/substrate-sdk-ios/tree/master/SubstrateSdk/Classes/Icon/Polkadot
//

import Blake2
import Foundation
import SwiftUI

public enum IdenticonError: Error {
    case unrecognizedAddress
    case noSchemeFound
}

fileprivate func deriveInternalIdFromBytes(_ bytes: [UInt8]) throws -> [UInt8] {
    let zero: [UInt8] = try Blake2b.hash(
        size: 64,
        data: Data(repeating: 0, count: 32)
    ).map { $0 }
    var bytes: [UInt8] = try Blake2b.hash(
        size: 64,
        data: Data(bytes)
    ).map { $0 }
    for index in (0..<zero.count) {
        let value = UInt(bytes[index])
        bytes[index] = UInt8((value + 256 - UInt(zero[index])) % 256)
    }
    return bytes
}

fileprivate func findScheme(for accumFreq: UInt) throws -> IdenticonScheme {
    var cum: UInt = 0
    for scheme in IdenticonScheme.all {
        cum += scheme.freq
        if accumFreq < cum {
            return scheme
        }
    }
    throw IdenticonError.noSchemeFound
}

extension AccountId {
    public func getIdenticonColors() throws -> [Color] {
        let accountId = try deriveInternalIdFromBytes(self.bytes)
        let total: UInt = IdenticonScheme.all.reduce(UInt(0)) { (result, scheme) in
            result + scheme.freq
        }
        let accumFreq = (UInt(accountId[30]) + UInt(accountId[31]) * 256) % total
        let rot = (accountId[28] % 6) * 3
        let sat = floor(CGFloat(accountId[29]) * 70.0 / 256.0 + 26.0)
            .truncatingRemainder(dividingBy: 80) + 30.0
        let scheme = try findScheme(for: accumFreq)
        var palette: [Color] = []
        for (index, byte) in accountId.enumerated() {
            let colorParam = (UInt(byte) + UInt(index) % 28 * 58) % 256
            if colorParam == 0 {
                let color = Color(hue: 0.0, saturation: 0.0, brightness: 0.27, opacity: 1.0)
                palette.append(color)
            } else if colorParam == 255 {
                let color = Color(white: 1.0, opacity: 0.0)
                palette.append(color)
            } else {
                let hue: CGFloat = floor(CGFloat(colorParam % 64) * 360.0 / 64.0)
                let lightness: CGFloat = [53.0, 15.0, 35.0, 75.0][Int(floor(CGFloat(colorParam) / 64.0))]
                let color = Color.colorWithHSL(
                    hue: hue,
                    saturation: CGFloat(sat) * 0.01 ,
                    lightness: CGFloat(lightness) * 0.01
                )
                palette.append(color)
            }
        }
        return (0..<scheme.colors.count).map { index in
            palette[Int(scheme.colors[index < 18 ? (index + Int(rot)) % 18 : 18])]
        }
    }
}
