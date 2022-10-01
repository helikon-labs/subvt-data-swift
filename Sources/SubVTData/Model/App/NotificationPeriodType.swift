public enum NotificationPeriodType: String, Codable, Hashable {
    case immediate,
         hour,
         day,
         epoch,
         era,
         off
}
