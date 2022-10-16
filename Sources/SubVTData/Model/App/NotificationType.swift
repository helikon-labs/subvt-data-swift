/**
 Notification type and its parameters types.
 */
public struct NotificationType: Hashable {
    public let code: String
    public let isEnabled: Bool
    public let paramTypes: [NotificationParamType]
    
    public init(
        code: String,
        isEnabled: Bool,
        paramTypes: [NotificationParamType]
    ) {
        self.code = code
        self.isEnabled = isEnabled
        self.paramTypes = paramTypes
    }
}

extension NotificationType: Codable {}
