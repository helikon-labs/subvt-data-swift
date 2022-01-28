import Alamofire
import Combine

/**
 SubVT report REST service.
 */
public final class ReportService: BaseService {
    init() {
        super.init(baseURL: Settings.shared.reportServiceURL)
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
}
