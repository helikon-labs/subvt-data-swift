/**
 Account and total stake.
 */
public struct NominatorStake: Codable {
    public let account: Account
    public let stake: Balance
    
    private enum CodingKeys: String, CodingKey {
        case account
        case stake
    }
}
