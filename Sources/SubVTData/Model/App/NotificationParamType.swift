public enum NotificationParamDataType: String, Codable {
    case string,
         integer,
         balance,
         float,
         boolean
}

/**
 Notification parameter type.
 These types are predefined in the SubVT database.
 */
public struct NotificationParamType {
    public let id: UInt64
    public let notificationTypeCode: String
    public let order: UInt8
    public let code: String
    public let type: NotificationParamDataType
    public let min: String?
    public let max: String?
    public let isOptional: Bool
    
    public init(
        id: UInt64,
        notificationTypeCode: String,
        order: UInt8,
        code: String,
        type: NotificationParamDataType,
        min: String?,
        max: String?,
        isOptional: Bool
    ) {
        self.id = id
        self.notificationTypeCode = notificationTypeCode
        self.order = order
        self.code = code
        self.type = type
        self.min = min
        self.max = max
        self.isOptional = isOptional
    }
}

extension NotificationParamType: Codable {}
