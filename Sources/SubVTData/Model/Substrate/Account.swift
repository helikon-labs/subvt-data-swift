/**
 A Substrate account as represented in the SubVT system.
 */
public struct Account {
    public let id: AccountId
    public let identity: IdentityRegistration?
    public let parent: Box<Account>?
    public let childDisplay: String?
    public let discoveredAt: UInt64?
    public let killedAt: UInt64?
    
    public init(
        id: AccountId,
        identity: IdentityRegistration?,
        parent: Box<Account>?,
        childDisplay: String?,
        discoveredAt: UInt64?,
        killedAt: UInt64?
    ) {
        self.id = id
        self.identity = identity
        self.parent = parent
        self.childDisplay = childDisplay
        self.discoveredAt = discoveredAt
        self.killedAt = killedAt
    }
}

extension Account: Codable {}

public class Box<T: Codable>: Codable {
    public let boxed: T
    public init(_ thingToBox: T) { boxed = thingToBox }
    
    public required init(from decoder: Decoder) throws {
        boxed = try T(from: decoder)
    }
    
    public func encode(to encoder: Encoder) throws {
        try boxed.encode(to: encoder)
    }
}
