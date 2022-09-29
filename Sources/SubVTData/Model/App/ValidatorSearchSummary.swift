/**
 Validator summary as returned from the search endpoint - a subset of the ValidatorSummary struct.
 */
public struct ValidatorSearchSummary: Codable, Hashable {
    public let accountId: AccountId
    public let address: String
    public private(set) var display: String?
    public private(set) var parentDisplay: String?
    public private(set) var childDisplay: String?
    public private(set) var confirmed: Bool
    public private(set) var inactiveNominations: InactiveNominationsSummary
    public private(set) var validatorStake: ValidatorStakeSummary?
    
    public init(
        accountId: AccountId,
        address: String,
        display: String?,
        parentDisplay: String?,
        childDisplay: String?,
        confirmed: Bool,
        inactiveNominations: InactiveNominationsSummary,
        validatorStake: ValidatorStakeSummary?
    ) {
        self.accountId = accountId
        self.address = address
        self.display = display
        self.parentDisplay = parentDisplay
        self.childDisplay = childDisplay
        self.confirmed = confirmed
        self.inactiveNominations = inactiveNominations
        self.validatorStake = validatorStake
    }
}
