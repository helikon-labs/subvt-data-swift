/**
 Era staker account id, total staked amount and active amount.
 */
public struct Stake: Hashable {
    public let stashAccountId: AccountId
    public let totalAmount: Balance
    public let activeAmount: Balance
    
    public init(
        stashAccountId: AccountId,
        totalAmount: Balance,
        activeAmount: Balance
    ) {
        self.stashAccountId = stashAccountId
        self.totalAmount = totalAmount
        self.activeAmount = activeAmount
    }
}

extension Stake: Codable {}

public struct StakeSummary: Hashable {
    public let stashAccountId: AccountId
    public let activeAmount: Balance
    
    public init(
        stashAccountId: AccountId,
        activeAmount: Balance
    ) {
        self.stashAccountId = stashAccountId
        self.activeAmount = activeAmount
    }
}

extension StakeSummary: Codable {}
