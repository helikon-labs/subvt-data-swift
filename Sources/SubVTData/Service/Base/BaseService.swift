import Alamofire
import AlamofireNetworkActivityLogger
import Combine
import Foundation

/**
 Base class for all network services.
 */
public class BaseService {
    private let baseURL: String
    private let session: Session
    
    init(baseURL: String) {
        self.baseURL = baseURL
        self.session = Session(
            interceptor: AuthInterceptor(storage: KeychainStorage.shared)
        )
        #if DEBUG
        NetworkActivityLogger.shared.startLogging()
        NetworkActivityLogger.shared.level = .debug
        #endif
    }
    
    private let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
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
                error: backendError
            )
        }
        return mapped
    }
    
    func get<T: Decodable>(
        path: String,
        parameters: [String: Any]
    ) -> AnyPublisher<DataResponse<T, APIError>, Never> {
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        return session.request(
            baseURL + path,
            method: .get,
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
    
    func post<U: Decodable>(
        path: String
    ) -> AnyPublisher<DataResponse<U, APIError>, Never> {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=utf-8"
        ]
        return session.request(
            baseURL + path,
            method: .post,
            headers: headers
        )
            .validate()
            .publishDecodable(type: U.self, decoder: jsonDecoder)
            .map(mapResponse)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
