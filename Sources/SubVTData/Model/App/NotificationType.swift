/**
 Notification type and its parameters types.
 */
public struct NotificationType: Hashable {
    public let code: String
    public let paramTypes: [NotificationParamType]
    
    public init(
        code: String,
        paramTypes: [NotificationParamType]
    ) {
        self.code = code
        self.paramTypes = paramTypes
    }
}

extension NotificationType: Codable {}
