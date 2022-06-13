import BigInt

/*
 Balance wrapper type - u128 in the backend domain.
 Represented by the BigUInt type in the Swift domain.
 Contains code/decode logic.
 */
public struct Balance {
    public let value: BigUInt
    
    public init(value: BigUInt) {
        self.value = value
    }
}

extension Balance: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let double = try container.decode(Double.self)
        value = BigUInt(
            String(format: "%.0f", double),
            radix: 10
        )!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode("\(value.description)")
    }
}

func decodeBigUInt<T>(
    _ container: KeyedDecodingContainer<T>,
    key: T
) throws -> BigUInt {
    let double = try container.decode(Double.self, forKey: key)
    return BigUInt(
        String(format: "%.0f", double),
        radix: 10
    )!
}
