import Foundation

public struct ValidatorEraPayoutReport: Hashable {
    public let era: Era
    public let payout: Balance
    
    public init(
        era: Era,
        payout: Balance
    ) {
        self.era = era
        self.payout = payout
    }
}

extension ValidatorEraPayoutReport: Codable {}
