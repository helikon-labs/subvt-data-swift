import Foundation

public enum NotificationChannelCode: String, Codable {
    case apns,
         fcm,
         telegram,
         email,
         gsm,
         sms
}

/**
 SubVT user notification channel type.
 */
public struct NotificationChannel: Codable {
    public let code: NotificationChannelCode
}
