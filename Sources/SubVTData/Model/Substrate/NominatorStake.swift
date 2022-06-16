/**
 Account and total stake.
 */
public struct NominatorStake: Hashable {
    public let account: Account
    public let stake: Balance
    
    public init(
        account: Account,
        stake: Balance
    ) {
        self.account = account
        self.stake = stake
    }
}

extension NominatorStake: Codable {}
