/**
 One of the user's notification channels.
 */
public struct UserNotificationChannel: Codable {
    public let id: UInt64
    public let userId: UInt64
    public let channelCode: NotificationChannelCode
    public let target: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case channelCode = "channel_code"
        case target
    }
}

public struct NewUserNotificationChannel: Codable {
    public let channelCode: NotificationChannelCode
    public let target: String
    
    private enum CodingKeys: String, CodingKey {
        case channelCode = "channel_code"
        case target
    }
}
