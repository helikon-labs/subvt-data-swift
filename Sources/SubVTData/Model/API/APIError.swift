/**
 API error type.
 Contains the causing error.
 */
import Alamofire

public struct APIError: Error {
    public init(initialError: AFError, backendError: BackendError?) {
        self.initialError = initialError
        self.backendError = backendError
    }
    
    public let initialError: AFError
    /**
     Non-null if the error is coming from the backend.
     */
    public let backendError: BackendError?
}

public struct BackendError: Codable, Error {
    public init(description: String) {
        self.description = description
    }
    
    public let description: String
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
}
