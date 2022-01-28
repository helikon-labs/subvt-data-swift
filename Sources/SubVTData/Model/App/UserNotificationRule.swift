/**
 Used when creating a new notification rule for the user.
 */
public struct CreateUserNotificationRuleRequest: Codable {
    let notificationTypeCode: String
    let name: String?
    let networkId: UInt64?
    let isForAllValidators: Bool
    let userValidatorIds: [UInt64]
    let periodType: NotificationPeriodType
    let period: UInt16
    let userNotificationChannelIds: [UInt64]
    let parameters: [NewUserNotificationRuleParameter]
    let notes: String?
    
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
    let userNotificationRuleId: UInt64
    let parameterTypeId: UInt64
    let parameterTypeCode: String
    let order: UInt8
    let value: String
    
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
    let parameterTypeId: UInt64
    let value: String
    
    private enum CodingKeys: String, CodingKey {
        case parameterTypeId = "parameter_type_id"
        case value
    }
}

/**
 Returned by the GETter service for the user's notification rules.
 */
public struct UserNotificationRule: Codable {
    let id: UInt64
    let userId: UInt64
    let notificationType: NotificationType
    let name: String?
    let network: Network?
    let isForAllValidators: Bool
    let periodType: NotificationPeriodType
    let period: UInt16
    let validators: [UserValidator]
    let notificationChannels: [UserNotificationChannel]
    let parameters: [UserNotificationRuleParameter]
    let notes: String?
    
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
