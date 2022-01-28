import Alamofire
import Combine

/**
 SubVT application REST service.
 */
public final class AppService: BaseService {
    init() {
        super.init(baseURL: Settings.shared.appServiceURL)
    }
    
    public func getNetworks() -> ServiceResponsePublisher<[Network]> {
        return get(path: "/network")
    }
    
    public func getNotificationChannels() -> ServiceResponsePublisher<[NotificationChannel]> {
        return get(path: "/notification/channel")
    }
    
    public func createUser() -> ServiceResponsePublisher<User> {
        return post(path: "/secure/user")
    }
}
