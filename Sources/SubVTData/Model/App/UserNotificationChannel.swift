/**
 One of the user's notification channels.
 */
public struct UserNotificationChannel {
    public let id: UInt64
    public let userId: UInt64
    public let channel: NotificationChannel
    public let target: String
    
    public init(
        id: UInt64,
        userId: UInt64,
        channel: NotificationChannel,
        target: String
    ) {
        self.id = id
        self.userId = userId
        self.channel = channel
        self.target = target
    }
}

extension UserNotificationChannel: Codable {}

public struct NewUserNotificationChannel {
    public let channel: NotificationChannel
    public let target: String
    
    public init(
        channel: NotificationChannel,
        target: String
    ) {
        self.channel = channel
        self.target = target
    }
}

extension NewUserNotificationChannel: Codable {}
