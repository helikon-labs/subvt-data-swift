/**
 A SubVT user defined by her public key (hex string).
 */
public struct User: Codable {
    public let id: UInt64
    public let publicKeyHex: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case publicKeyHex = "public_key_hex"
    }
}
