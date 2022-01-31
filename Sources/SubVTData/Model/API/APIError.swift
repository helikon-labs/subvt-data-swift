/**
 API error type.
 Contains the causing error.
 */
import Alamofire

public struct APIError: Error {
    public let initialError: AFError
    /**
     Non-null if the error is coming from the backend.
     */
    public let backendError: BackendError?
}

public struct BackendError: Codable, Error {
    public let description: String
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
}
