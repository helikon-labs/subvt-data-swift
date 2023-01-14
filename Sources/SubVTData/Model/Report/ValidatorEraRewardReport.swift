import Foundation

public struct ValidatorEraRewardReport: Hashable {
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

extension ValidatorEraRewardReport: Codable {}
