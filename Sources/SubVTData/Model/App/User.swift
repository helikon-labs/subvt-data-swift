/**
 A SubVT user defined by her public key (hex string).
 */
public struct User: Hashable {
    public let id: UInt64
    public let publicKeyHex: String
    
    public init(
        id: UInt64,
        publicKeyHex: String
    ) {
        self.id = id
        self.publicKeyHex = publicKeyHex
    }
}

extension User: Codable {}
