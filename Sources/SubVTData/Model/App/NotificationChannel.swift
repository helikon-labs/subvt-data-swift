/**
 SubVT user notification channel type.
 */
public enum NotificationChannel: String, Codable, Hashable {
    case apns,
         fcm,
         telegram,
         email,
         gsm,
         sms
}
