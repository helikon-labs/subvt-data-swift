/**
 SubVT user notification channel type.
 */
public enum NotificationChannel: String, Codable {
    case apns,
         fcm,
         telegram,
         email,
         gsm,
         sms
}
