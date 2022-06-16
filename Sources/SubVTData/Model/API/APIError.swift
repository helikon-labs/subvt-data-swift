/**
 API error type.
 Contains the causing error.
 */
import Alamofire

public struct APIError: Error, Hashable {
    public init(initialError: AFError, backendError: BackendError?) {
        self.initialError = initialError
        self.backendError = backendError
    }
    
    public let initialError: AFError
    /**
     Non-null if the error is coming from the backend.
     */
    public let backendError: BackendError?
    
    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        return (lhs.initialError.responseCode == rhs.initialError.responseCode
                && lhs.backendError == rhs.backendError)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.initialError.responseCode)
        hasher.combine(self.backendError?.description ?? "")
    }
}

public struct BackendError: Codable, Error, Hashable {
    public init(description: String) {
        self.description = description
    }
    
    public let description: String
    
    private enum CodingKeys: String, CodingKey {
        case description
    }
}
