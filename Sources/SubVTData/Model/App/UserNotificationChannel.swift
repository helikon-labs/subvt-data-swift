/**
 One of the user's notification channels.
 */
public struct UserNotificationChannel: Codable {
    public let id: UInt64
    public let userId: UInt64
    public let channelCode: NotificationChannelCode
    public let target: String
}

public struct NewUserNotificationChannel: Codable {
    public let channelCode: NotificationChannelCode
    public let target: String
}
