import Foundation

public struct ValidatorListReport: Hashable {
    public let finalizedBlock: BlockSummary
    public let validators: [ValidatorSummary]
    
    public init(
        finalizedBlock: BlockSummary,
        validators: [ValidatorSummary]
    ) {
        self.finalizedBlock = finalizedBlock
        self.validators = validators
    }
}

extension ValidatorListReport: Codable {}
