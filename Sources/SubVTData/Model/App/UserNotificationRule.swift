/**
 Used when creating a new notification rule for the user.
 */
public struct CreateUserNotificationRuleRequest {
    public let notificationTypeCode: String
    public let name: String?
    public let networkId: UInt64?
    public let isForAllValidators: Bool
    public let userValidatorIds: [UInt64]
    public let periodType: NotificationPeriodType
    public let period: UInt16
    public let userNotificationChannelIds: [UInt64]
    public let parameters: [NewUserNotificationRuleParameter]
    public let notes: String?
}

extension CreateUserNotificationRuleRequest: Codable {}

/**
 Actual parameter for a rule - returned by the GET rule service.
 */
public struct UserNotificationRuleParameter {
    public let userNotificationRuleId: UInt64
    public let parameterTypeId: UInt64
    public let parameterTypeCode: String
    public let order: UInt8
    public let value: String
}

extension UserNotificationRuleParameter: Codable {}

/**
 Used in the request to create a new notification rule for the user.
 */
public struct NewUserNotificationRuleParameter {
    public let parameterTypeId: UInt64
    public let value: String
}

extension NewUserNotificationRuleParameter: Codable {}

/**
 Returned by the GETter service for the user's notification rules.
 */
public struct UserNotificationRule {
    public let id: UInt64
    public let userId: UInt64
    public let notificationType: NotificationType
    public let name: String?
    public let network: Network?
    public let isForAllValidators: Bool
    public let periodType: NotificationPeriodType
    public let period: UInt16
    public let validators: [UserValidator]
    public let notificationChannels: [UserNotificationChannel]
    public let parameters: [UserNotificationRuleParameter]
    public let notes: String?
}

extension UserNotificationRule: Codable {}
