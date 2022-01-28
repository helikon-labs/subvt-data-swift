/**
 Notification type and its parameters types.
 */
public struct NotificationType: Codable {
    public let code: String
    public let paramTypes: [NotificationParamType]
    
    private enum CodingKeys: String, CodingKey {
        case code
        case paramTypes = "param_types"
    }
}
