import Alamofire
import Combine
import Foundation

public final class ReportService: BaseService {
    
    init() {
        super.init(baseURL: "http://\(Settings.shared.apiHost):\(Settings.shared.reportServicePort)")
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
