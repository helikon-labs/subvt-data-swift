/**
 One of the user's notification channels.
 */
public struct UserNotificationChannel {
    public let id: UInt64
    public let userId: UInt64
    public let channel: NotificationChannel
    public let target: String
}

extension UserNotificationChannel: Codable {}

public struct NewUserNotificationChannel {
    public let channel: NotificationChannel
    public let target: String
}

extension NewUserNotificationChannel: Codable {}
