import Foundation

public struct MonthlyIncome: Hashable {
    public let year: UInt32
    public let month: UInt32
    public let income: Decimal
}

extension MonthlyIncome: Codable {}

public struct MonthlyIncomeReport {
    public let rewardee: AccountId
    public let tokenSymbol: String
    public let monthlyIncome: [MonthlyIncome]
}

extension MonthlyIncomeReport: Codable {}
