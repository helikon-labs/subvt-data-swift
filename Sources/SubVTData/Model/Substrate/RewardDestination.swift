public enum RewardDestination: Codable {
    case account(accountId: AccountId)
    case controller
    case none
    case staked
    case stash
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        switch value {
        case "Controller":
            self = .controller
        case "None":
            self = .none
        case "Staked":
            self = .staked
        case "Stash":
            self = .stash
        default: // account
            let hex = value.replacingOccurrences(
                of: "Account(",
                with: ""
            ).replacingOccurrences(
                of: ")",
                with: ""
            )
            self = .account(
                accountId: AccountId(hex: hex)
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .account(let accountId):
            let hex = accountId.toHex()
            try container.encode("Account(\(hex))")
        case .controller:
            try container.encode("Controller")
        case .none:
            try container.encode("None")
        case .staked:
            try container.encode("Staked")
        case .stash:
            try container.encode("Stash")
        }
    }
}


