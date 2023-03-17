import Foundation

public struct LogConfig {
   public let showDate: Bool
   public let useVerboseTypeText: Bool
   public let dateFormat: String
   /**
    * - Parameters:
    *   - showDate: Adds timestamp to the begining of the print [22-12-24-01:54:22] - ...
    *   - useVerboseTypeText: Adds text to the emoji. [📣 Information]
    *   - dateFormat: Timzone is always utc
    */
   public init(showDate: Bool, useVerboseTypeText: Bool, dateFormat: String = defaultDateFormat) {
      self.showDate = showDate
      self.useVerboseTypeText = useVerboseTypeText
      self.dateFormat = dateFormat
   }
}

/**
 * Getter
 */
extension LogConfig {
   /**
    * Default date format
    */
   public static let defaultDateFormat: String = "yyyy-MM-dd' 'HH:mm:ss"
   /**
    * DateFormatter
    */
   var dateFormatter: DateFormatter {
      let format = DateFormatter()
      format.dateFormat = dateFormat
      format.timeZone = TimeZone(identifier: "UTC")
      format.locale = Locale(identifier: "en_US_POSIX")
      return format
   }
}
