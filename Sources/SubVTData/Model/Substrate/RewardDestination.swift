public enum RewardDestinationType: String, Hashable, Codable {
    case account = "Account"
    case controller = "Controller"
    case none = "None"
    case staked = "Staked"
    case stash = "Stash"
}

/**
 Reward destination preference of a validator.
 */
public struct RewardDestination: Hashable, Codable {
    public let destinationType: RewardDestinationType
    public let destination: AccountId?
}
