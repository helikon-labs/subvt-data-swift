import Alamofire
import Combine

/**
 SubVT application REST service.
 */
public final class AppService: BaseService {
    init() {
        super.init(baseURL: Settings.shared.appServiceURL)
    }
    
    public func createUser() -> AnyPublisher<DataResponse<User, APIError>, Never> {
        return post(path: "/secure/user")
    }
}
