import Alamofire
import Combine
import Foundation

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
    ) -> AnyPublisher<DataResponse<[EraReport], APIError>, Never> {
        var parameters: Parameters = [
            "start_era_index": startEraIndex,
        ]
        if let endEraIndex = endEraIndex {
            parameters["end_era_index"] = endEraIndex
        }
        return get(
            path: "/report/era",
            parameters: parameters
        )
    }
    
    public func getEraValidatorReport(
        validatorAccountId: AccountId,
        startEraIndex: Int,
        endEraIndex: UInt? = nil
    ) -> AnyPublisher<DataResponse<[EraValidatorReport], APIError>, Never> {
        var parameters: Parameters = [
            "start_era_index": startEraIndex,
        ]
        if let endEraIndex = endEraIndex {
            parameters["end_era_index"] = endEraIndex
        }
        return get(
            path: "/report/validator/\(validatorAccountId.toHex())",
            parameters: parameters
        )
    }
}
