import Alamofire
import Combine

/**
 SubVT report REST service.
 */
public final class ReportService: BaseRESTService {
    public init() {
        super.init(
            host: Settings.shared.apiHost,
            port: Settings.shared.reportServicePort
        )
    }
    
    public override init(host: String, port: UInt16) {
        super.init(host: host, port: port)
    }
    
    public func getEraReport(
        startEraIndex: UInt32,
        endEraIndex: UInt32? = nil
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
        startEraIndex: UInt32,
        endEraIndex: UInt32? = nil
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
    
    public func getOneKVNominatorSummaries() -> ServiceResponsePublisher<[OneKVNominatorSummary]> {
        return perform(
            path: "/onekv/nominator",
            method: .get
        )
    }
    
    public func getAllEras() -> ServiceResponsePublisher<[Era]> {
        return perform(
            path: "/era",
            method: .get
        )
    }
    
    public func getCurrentEra() -> ServiceResponsePublisher<Era> {
        return perform(
            path: "/era/current",
            method: .get
        )
    }
    
    public func getValidatorEraRewardReport(
        validatorAccountId: AccountId
    ) -> ServiceResponsePublisher<[ValidatorEraRewardReport]> {
        return perform(
            path: "/validator/\(validatorAccountId.toHex())/era/reward",
            method: .get
        )
    }
    
    public func getValidatorEraPayoutReport(
        validatorAccountId: AccountId
    ) -> ServiceResponsePublisher<[ValidatorEraPayoutReport]> {
        return perform(
            path: "/validator/\(validatorAccountId.toHex())/era/payout",
            method: .get
        )
    }
    
    public func getSessionValidatorReport(
        validatorAccountId: AccountId,
        startSessionIndex: UInt32,
        endSessionIndex: UInt32? = nil
    ) -> ServiceResponsePublisher<[SessionValidatorReport]> {
        var parameters: Parameters = [
            "start_session_index": startSessionIndex,
        ]
        if let endSessionIndex = endSessionIndex {
            parameters["end_session_index"] = endSessionIndex
        }
        return perform(
            path: "/report/session/validator/\(validatorAccountId.toHex())",
            method: .get,
            parameters: parameters
        )
    }
    
    public func getCurrentSession() -> ServiceResponsePublisher<Epoch> {
        return perform(
            path: "/session/current",
            method: .get
        )
    }
    
    public func getNetworkStatus() -> ServiceResponsePublisher<NetworkStatus> {
        return perform(
            path: "/network/status",
            method: .get
        )
    }
}
