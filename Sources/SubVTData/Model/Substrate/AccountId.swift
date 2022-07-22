/**
 Account id-related classes and functions.
 */

import Base58Swift
import Blake2
import Foundation

fileprivate let accountIdLength = 32
fileprivate let checksumLength = 2
fileprivate let blake2bMaxLength = 64
fileprivate let ss58Pre = "SS58PRE"

public struct AccountId: CustomStringConvertible, Hashable {
    let bytes: [UInt8]
    
    public init(bytes: [UInt8]) {
        self.bytes = bytes
    }
    
    public init(hex: String) {
        if hex.starts(with: "0x") {
            bytes = hex.dropFirst(2).hexBytes
        } else {
            bytes = hex.hexBytes
        }
        precondition(
            bytes.count == accountIdLength,
            "Account id should be 32 bytes long."
        )
    }
    
    public func toHex() -> String {
        return "0x" + bytes.map {
            String(format: "%02hhX", $0)
        }.joined()
    }
    
    public var description: String {
        return toHex()
    }
    
    public func toSS58Check(prefix: UInt16) throws -> String {
        var accountId = Data(self.bytes)
        var prefix = prefix
        let ident = prefix & 0b0011111111111111;
        let addressData = NSMutableData()
        if ident < 64 {
            addressData.append(Data(bytes: &prefix, count: 1))
        } else {
            var first = ((ident & 0b0000000011111100) >> 2) | 0b01000000;
            var second = (ident >> 8 | (ident & 0b0000000000000011) << 6);
            addressData.append(&first, length: 1)
            addressData.append(&second, length: 1)
        }
        
        if accountId.count != accountIdLength {
            accountId = try Blake2.hash(.b2b, size: accountIdLength, data: accountId)
        }
        addressData.append(accountId)
        
        let checksumData = NSMutableData()
        let ss58PreData = ss58Pre.data(using: .utf8) ?? Data()
        checksumData.append(ss58PreData)
        checksumData.append(addressData as Data)
        let hash = try Blake2.hash(.b2b, size: blake2bMaxLength, data: checksumData as Data)
        addressData.append(hash.subdata(in: 0..<checksumLength))
        let bytes = Array(addressData as Data)
        return Base58.base58Encode(bytes)
    }
}

extension AccountId: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hex: hex)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(toHex())")
    }
}
