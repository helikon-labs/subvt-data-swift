/**
 Notification type and its parameters types.
 */
public struct NotificationType {
    public let code: String
    public let paramTypes: [NotificationParamType]
}

extension NotificationType: Codable {}
