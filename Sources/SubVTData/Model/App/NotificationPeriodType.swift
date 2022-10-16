public enum NotificationPeriodType: String, Codable, Hashable, CaseIterable {
    case off,
         immediate,
         hour,
         day,
         epoch,
         era
}
