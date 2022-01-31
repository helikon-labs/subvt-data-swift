import Alamofire
import AlamofireNetworkActivityLogger
import Combine
import Foundation

public typealias ServiceResponsePublisher<T> = AnyPublisher<DataResponse<T, APIError>, Never>

public struct EmptyResponse: Codable {}

/**
 Base class for all network services.
 */
public class BaseRESTService {
    private let baseURL: String
    private let session: Session
    
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    
    init(baseURL: String) {
        self.baseURL = baseURL
        self.session = Session(
            interceptor: AuthInterceptor(storage: KeychainStorage.shared)
        )
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
        #if DEBUG
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        #endif
    }
    
    private func mapResponse<T>(response: DataResponsePublisher<T>.Output) -> DataResponse<T, APIError> {
        let mapped: DataResponse<T, APIError> = response.mapError { error in
            let backendError = response.data.flatMap {
                try? jsonDecoder.decode(
                    BackendError.self,
                    from: $0
                )
            }
            return APIError(
                initialError: error,
                backendError: backendError
            )
        }
        return mapped
    }
    
    func perform<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil
    ) -> AnyPublisher<DataResponse<T, APIError>, Never> {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return session.request(
            baseURL + path,
            method: method,
            parameters: parameters,
            encoding: URLEncoding.queryString,
            headers: headers
        )
            .validate()
            .publishDecodable(type: T.self, decoder: jsonDecoder)
            .map(mapResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func performWithBody<E: Encodable, T: Decodable>(
        path: String,
        method: HTTPMethod,
        body: E? = nil
    ) -> AnyPublisher<DataResponse<T, APIError>, Never> {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
        return session.request(
            baseURL + path,
            method: method,
            parameters: body,
            encoder: JSONParameterEncoder(encoder: jsonEncoder),
            headers: headers
        )
            .validate()
            .publishDecodable(type: T.self, decoder: jsonDecoder)
            .map(mapResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
