import Foundation

public struct AccountId: CustomStringConvertible {
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
    
    func toHex() -> String {
        return description
    }
    
    public var description: String {
        "0x" + bytes.map {
            String(format: "%02hhX", $0)
        }.joined()
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
