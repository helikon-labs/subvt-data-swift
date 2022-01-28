/**
 Account id-related classes and functions.
 */
import Foundation

public struct AccountId: CustomStringConvertible, Codable {
    let bytes: [UInt8]
    
    init(hex: String) {
        if hex.starts(with: "0x") {
            bytes = hex.dropFirst(2).hexBytes
        } else {
            bytes = hex.hexBytes
        }
        precondition(
            bytes.count == 32,
            "Account id should be 32 bytes long."
        )
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let hex = try container.decode(String.self)
        self.init(hex: hex)
    }
    
    func toHex() -> String {
        return "0x" + bytes.map {
            String(format: "%02hhX", $0)
        }.joined()
    }
    
    public var description: String {
        return toHex()
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(toHex())")
    }
}

private extension StringProtocol {
    var hexData: Data { .init(hex) }
    var hexBytes: [UInt8] { .init(hex) }
    private var hex: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}
