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
        return perform(path: "/network", method: .get)
    }
    
    public func getNotificationChannels() -> ServiceResponsePublisher<[NotificationChannel]> {
        return perform(path: "/notification/channel", method: .get)
    }
    
    public func getNotificationTypes() -> ServiceResponsePublisher<[NotificationType]> {
        return perform(path: "/notification/type", method: .get)
    }
    
    public func createUser() -> ServiceResponsePublisher<User> {
        return perform(path: "/secure/user", method: .post)
    }
    
    public func getUserNotificationChannels() -> ServiceResponsePublisher<[UserNotificationChannel]> {
        return perform(path: "/secure/user/notification/channel", method: .get)
    }
    
    public func createUserNotificationChannel(
        channel: NewUserNotificationChannel
    ) -> ServiceResponsePublisher<UserNotificationChannel> {
        return performWithBody(
            path: "/secure/user/notification/channel",
            method: .post,
            body: channel
        )
    }
    
    public func deleteUserNotificationChannel(
        id: UInt64
    ) -> ServiceResponsePublisher<EmptyResponse> {
        return perform(
            path: "/secure/user/notification/channel/\(id)",
            method: .delete
        )
    }
    
    public func getUserValidators() -> ServiceResponsePublisher<[UserValidator]> {
        return perform(path: "/secure/user/validator", method: .get)
    }
    
    public func createUserValidator(
        validator: NewUserValidator
    ) -> ServiceResponsePublisher<UserValidator> {
        return performWithBody(
            path: "/secure/user/validator",
            method: .post,
            body: validator
        )
    }
    
    public func deleteUserValidator(
        id: UInt64
    ) -> ServiceResponsePublisher<EmptyResponse> {
        return perform(
            path: "/secure/user/validator/\(id)",
            method: .delete
        )
    }
    
    public func getUserNotificationRules() -> ServiceResponsePublisher<[UserNotificationRule]> {
        return perform(path: "/secure/user/notification/rule", method: .get)
    }
    
    public func createUserNotificationRule(
        request: CreateUserNotificationRuleRequest
    ) -> ServiceResponsePublisher<UserNotificationRule> {
        return performWithBody(
            path: "/secure/user/notification/rule",
            method: .post,
            body: request
        )
    }
    
    public func deleteUserNotificationRule(
        id: UInt64
    ) -> ServiceResponsePublisher<EmptyResponse> {
        return perform(
            path: "/secure/user/notification/rule/\(id)",
            method: .delete
        )
    }
}
