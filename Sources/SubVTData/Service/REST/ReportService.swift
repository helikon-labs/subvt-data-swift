import Alamofire
import Combine

/**
 SubVT report REST service.
 */
public final class ReportService: BaseRESTService {
    public init() {
        super.init(baseURL: Settings.shared.reportServiceURL)
    }
    
    public override init(baseURL: String) {
        super.init(baseURL: baseURL)
    }
    
    public func getEraReport(
        startEraIndex: Int,
        endEraIndex: UInt? = nil
    ) -> ServiceResponsePublisher<[EraReport]> {
        var parameters: Parameters = [
            "start_era_index": startEraIndex,
        ]
        if let endEraIndex = endEraIndex {
            parameters["end_era_index"] = endEraIndex
        }
        return perform(
            path: "/report/era",
            method: .get,
            parameters: parameters
        )
    }
    
    public func getEraValidatorReport(
        validatorAccountId: AccountId,
        startEraIndex: Int,
        endEraIndex: UInt? = nil
    ) -> ServiceResponsePublisher<[EraValidatorReport]> {
        var parameters: Parameters = [
            "start_era_index": startEraIndex,
        ]
        if let endEraIndex = endEraIndex {
            parameters["end_era_index"] = endEraIndex
        }
        return perform(
            path: "/report/validator/\(validatorAccountId.toHex())",
            method: .get,
            parameters: parameters
        )
    }
    
    public func getValidatorDetailsReport(
        validatorAccountId: AccountId
    ) -> ServiceResponsePublisher<ValidatorDetailsReport> {
        return perform(
            path: "/validator/\(validatorAccountId.toHex())/details",
            method: .get
        )
    }
    
    public func getValidatorSummaryReport(
        validatorAccountId: AccountId
    ) -> ServiceResponsePublisher<ValidatorSummaryReport> {
        return perform(
            path: "/validator/\(validatorAccountId.toHex())/summary",
            method: .get
        )
    }
    
    public func getValidatorListReport() -> ServiceResponsePublisher<ValidatorListReport> {
        return perform(
            path: "/validator/list",
            method: .get
        )
    }
    
    public func getActiveValidatorListReport() -> ServiceResponsePublisher<ValidatorListReport> {
        return perform(
            path: "/validator/list/active",
            method: .get
        )
    }
    
    public func getInactiveValidatorListReport() -> ServiceResponsePublisher<ValidatorListReport> {
        return perform(
            path: "/validator/list/inactive",
            method: .get
        )
    }
    
    public func searchValidators(query: String) -> ServiceResponsePublisher<[ValidatorSearchSummary]> {
        let parameters: Parameters = [
            "query": query,
        ]
        return perform(
            path: "/validator/search",
            method: .get,
            parameters: parameters
        )
    }
}
