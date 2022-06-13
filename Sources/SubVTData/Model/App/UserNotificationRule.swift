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
    
    public init(
        notificationTypeCode: String,
        name: String?,
        networkId: UInt64?,
        isForAllValidators: Bool,
        userValidatorIds: [UInt64],
        periodType: NotificationPeriodType,
        period: UInt16, userNotificationChannelIds: [UInt64],
        parameters: [NewUserNotificationRuleParameter],
        notes: String?
    ) {
        self.notificationTypeCode = notificationTypeCode
        self.name = name
        self.networkId = networkId
        self.isForAllValidators = isForAllValidators
        self.userValidatorIds = userValidatorIds
        self.periodType = periodType
        self.period = period
        self.userNotificationChannelIds = userNotificationChannelIds
        self.parameters = parameters
        self.notes = notes
    }
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
    
    public init(
        userNotificationRuleId: UInt64,
        parameterTypeId: UInt64,
        parameterTypeCode: String,
        order: UInt8,
        value: String
    ) {
        self.userNotificationRuleId = userNotificationRuleId
        self.parameterTypeId = parameterTypeId
        self.parameterTypeCode = parameterTypeCode
        self.order = order
        self.value = value
    }
}

extension UserNotificationRuleParameter: Codable {}

/**
 Used in the request to create a new notification rule for the user.
 */
public struct NewUserNotificationRuleParameter {
    public let parameterTypeId: UInt64
    public let value: String
    
    public init(parameterTypeId: UInt64, value: String) {
        self.parameterTypeId = parameterTypeId
        self.value = value
    }
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
    
    public init(
        id: UInt64,
        userId: UInt64,
        notificationType: NotificationType,
        name: String?,
        network: Network?,
        isForAllValidators: Bool,
        periodType: NotificationPeriodType,
        period: UInt16,
        validators: [UserValidator],
        notificationChannels: [UserNotificationChannel],
        parameters: [UserNotificationRuleParameter],
        notes: String?
    ) {
        self.id = id
        self.userId = userId
        self.notificationType = notificationType
        self.name = name
        self.network = network
        self.isForAllValidators = isForAllValidators
        self.periodType = periodType
        self.period = period
        self.validators = validators
        self.notificationChannels = notificationChannels
        self.parameters = parameters
        self.notes = notes
    }
}

extension UserNotificationRule: Codable {}
