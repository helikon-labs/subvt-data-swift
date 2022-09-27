/**
 Validator summary as returned from the search endpoint - a subset of the ValidatorSummary struct.
 */
public struct ValidatorSearchSummary: Codable, Hashable {
    public let address: String
    public private(set) var display: String?
    public private(set) var parentDisplay: String?
    public private(set) var childDisplay: String?
    public private(set) var confirmed: Bool
    
    public init(
        address: String,
        display: String?,
        parentDisplay: String?,
        childDisplay: String?,
        confirmed: Bool
    ) {
        self.address = address
        self.display = display
        self.parentDisplay = parentDisplay
        self.childDisplay = childDisplay
        self.confirmed = confirmed
    }
}
