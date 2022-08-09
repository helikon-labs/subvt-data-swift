import Foundation

public struct ValidatorDetailsReport: Hashable {
    public let finalizedBlock: BlockSummary
    public let validatorDetails: ValidatorDetails
    
    public init(
        finalizedBlock: BlockSummary,
        validatorDetails: ValidatorDetails
    ) {
        self.finalizedBlock = finalizedBlock
        self.validatorDetails = validatorDetails
    }
}

extension ValidatorDetailsReport: Codable {}
