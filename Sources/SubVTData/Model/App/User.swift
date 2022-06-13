/**
 A SubVT user defined by her public key (hex string).
 */
public struct User {
    public let id: UInt64
    public let publicKeyHex: String
}

extension User: Codable {}
