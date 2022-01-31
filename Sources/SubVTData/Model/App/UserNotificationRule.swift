/**
 Used when creating a new notification rule for the user.
 */
public struct CreateUserNotificationRuleRequest: Codable {
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
    
    private enum CodingKeys: String, CodingKey {
        case notificationTypeCode = "notification_type_code"
        case name
        case networkId = "network_id"
        case isForAllValidators = "is_for_all_validators"
        case userValidatorIds = "user_validator_ids"
        case periodType = "period_type"
        case period
        case userNotificationChannelIds = "user_notification_channel_ids"
        case parameters
        case notes
    }
}

/**
 Actual parameter for a rule - returned by the GET rule service.
 */
public struct UserNotificationRuleParameter: Codable {
    public let userNotificationRuleId: UInt64
    public let parameterTypeId: UInt64
    public let parameterTypeCode: String
    public let order: UInt8
    public let value: String
    
    private enum CodingKeys: String, CodingKey {
        case userNotificationRuleId = "user_notification_rule_id"
        case parameterTypeId = "parameter_type_id"
        case parameterTypeCode = "parameter_type_code"
        case order
        case value
    }
}

/**
 Used in the request to create a new notification rule for the user.
 */
public struct NewUserNotificationRuleParameter: Codable {
    public let parameterTypeId: UInt64
    public let value: String
    
    private enum CodingKeys: String, CodingKey {
        case parameterTypeId = "parameter_type_id"
        case value
    }
}

/**
 Returned by the GETter service for the user's notification rules.
 */
public struct UserNotificationRule: Codable {
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
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case notificationType = "notification_type"
        case name
        case network
        case isForAllValidators = "is_for_all_validators"
        case periodType = "period_type"
        case period
        case validators
        case notificationChannels = "notification_channels"
        case parameters
        case notes
    }
}
