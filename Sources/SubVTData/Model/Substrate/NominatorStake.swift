/**
 Account and total stake.
 */
public struct NominatorStake {
    public let account: Account
    public let stake: Balance
}

extension NominatorStake: Codable {}
