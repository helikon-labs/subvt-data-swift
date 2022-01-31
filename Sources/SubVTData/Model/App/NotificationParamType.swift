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
public struct NotificationParamType: Codable {
    public let id: UInt64
    public let notificationTypeCode: String
    public let order: UInt8
    public let code: String
    public let type: NotificationParamDataType
    public let min: String?
    public let max: String?
    public let isOptional: Bool
}
