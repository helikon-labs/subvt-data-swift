import Alamofire

public struct APIError: Error {
    let initialError: AFError
    let error: BackendError?
}

public struct BackendError: Codable, Error {
    let description: String
}
