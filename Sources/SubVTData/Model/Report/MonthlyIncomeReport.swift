import Foundation

public struct MonthlyIncome: Hashable {
    public let year: UInt32
    public let month: UInt32
    public let income: Decimal
    
    public init(
        year: UInt32,
        month: UInt32,
        income: Decimal
    ) {
        self.year = year
        self.month = month
        self.income = income
    }
}

extension MonthlyIncome: Codable {}

public struct MonthlyIncomeReport {
    public let rewardee: AccountId
    public let tokenSymbol: String
    public let monthlyIncome: [MonthlyIncome]
    
    public init(
        rewardee: AccountId,
        tokenSymbol: String,
        monthlyIncome: [MonthlyIncome]
    ) {
        self.rewardee = rewardee
        self.tokenSymbol = tokenSymbol
        self.monthlyIncome = monthlyIncome
    }
}

extension MonthlyIncomeReport: Codable {}
