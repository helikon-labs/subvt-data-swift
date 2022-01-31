/**
 A validator represented by the active or inactive validator details service.
 */
public struct ValidatorSummary: Codable {
    public let accountId: AccountId
    public let controllerAccountId: AccountId?
    public let display: String?
    public let parentDisplay: String?
    public let childDisplay: String?
    public let confirmed: Bool
    public let preferences: ValidatorPreferences
    public let selfStake: StakeSummary
    public let isActive: Bool
    public let activeNextSession: Bool
    public let inactiveNominations: InactiveNominationsSummary
    public let oversubscribed: Bool
    public let slashCount: Int
    public let isEnrolledIn1Kv: Bool
    public let isParaValidator: Bool
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
}

public struct ValidatorSummaryDiff: Codable {
    public let accountId: AccountId
    public let controllerAccountId: AccountId?
    public let display: String?
    public let parentDisplay: String?
    public let childDisplay: String?
    public let confirmed: Bool?
    public let preferences: ValidatorPreferences?
    public let selfStake: StakeSummary?
    public let isActive: Bool?
    public let activeNextSession: Bool?
    public let inactiveNominations: InactiveNominationsSummary?
    public let oversubscribed: Bool?
    public let slashCount: Int?
    public let isEnrolledIn1Kv: Bool?
    public let isParaValidator: Bool?
    public let paraId: Int?
    public let returnRatePerBillion: UInt64?
    public let blocksAuthored: Int?
    public let rewardPoints: UInt64?
    public let heartbeatReceived: Bool?
    public let validatorStake: ValidatorStakeSummary?
}

public struct ValidatorListUpdate: Codable {
    public let finalizedBlockNumber: UInt64?
    public let insert: [ValidatorSummary]
    public let update: [ValidatorSummaryDiff]
    public let removeIds: [String]
}
