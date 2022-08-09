import Foundation

public struct ValidatorSummaryReport: Hashable {
    public let finalizedBlock: BlockSummary
    public let validatorSummary: ValidatorSummary
    
    public init(
        finalizedBlock: BlockSummary,
        validatorSummary: ValidatorSummary
    ) {
        self.finalizedBlock = finalizedBlock
        self.validatorSummary = validatorSummary
    }
}

extension ValidatorSummaryReport: Codable {}
