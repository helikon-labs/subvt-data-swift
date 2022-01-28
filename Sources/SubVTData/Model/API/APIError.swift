/**
 API error type.
 Contains the causing error.
 */
import Alamofire

public struct APIError: Error {
    let initialError: AFError
    /**
     Non-null if the error is coming from the backend.
     */
    let backendError: BackendError?
}

public struct BackendError: Codable, Error {
    let description: String
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
}
