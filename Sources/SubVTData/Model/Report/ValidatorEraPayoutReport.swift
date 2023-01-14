import Foundation

public struct ValidatorEraPayoutReport: Hashable {
    public let era: Era
    public let reward: Balance
    
    public init(
        era: Era,
        reward: Balance
    ) {
        self.era = era
        self.reward = reward
    }
}

extension ValidatorEraPayoutReport: Codable {}
