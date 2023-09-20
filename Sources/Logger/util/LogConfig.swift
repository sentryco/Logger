import Foundation

// LogConfig is a structure that defines the configuration for logging.
public struct LogConfig {
   // showDate determines whether to include the timestamp at the beginning of the log.
   public let showDate: Bool
   // useVerboseTypeText determines whether to include text with the emoji in the log.
   public let useVerboseTypeText: Bool
   // dateFormat specifies the format of the date to be used in the log.
   public let dateFormat: String

   /**
    * Initializer for LogConfig
    * - Parameters:
    *   - showDate: If true, adds timestamp to the beginning of the print. Example: [22-12-24-01:54:22] - ...
    *   - useVerboseTypeText: If true, adds text to the emoji. Example: [📣 Information]
    *   - dateFormat: The format of the date. The timezone is always UTC. Default is "yyyy-MM-dd' 'HH:mm:ss".
    */
   public init(showDate: Bool, useVerboseTypeText: Bool, dateFormat: String = defaultDateFormat) {
      self.showDate = showDate
      self.useVerboseTypeText = useVerboseTypeText
      self.dateFormat = dateFormat
   }
}

// Extension of LogConfig for getter methods and constants.
extension LogConfig {
   /**
    * Default date format is "yyyy-MM-dd' 'HH:mm:ss".
    */
   public static let defaultDateFormat: String = "yyyy-MM-dd' 'HH:mm:ss"

   /**
    * DateFormatter is used to format the date in the log.
    * It uses the dateFormat specified in the LogConfig, sets the timezone to UTC, and sets the locale to "en_US_POSIX".
    */
   var dateFormatter: DateFormatter {
      let format = DateFormatter()
      format.dateFormat = dateFormat
      format.timeZone = TimeZone(identifier: "UTC")
      format.locale = Locale(identifier: "en_US_POSIX")
      return format
   }
}

// Extension of LogConfig for predefined configurations.
extension LogConfig {
   /**
    * plain is a predefined LogConfig that does not show date and does not use verbose type text.
    * It uses the default date format.
    */
   public static let plain: LogConfig = {
      .init(showDate: false, useVerboseTypeText: false, dateFormat: defaultDateFormat)
   }()

   /**
    * full is a predefined LogConfig that shows date and uses verbose type text.
    * It uses the default date format.
    */
   public static let full: LogConfig = {
      .init(showDate: true, useVerboseTypeText: true, dateFormat: defaultDateFormat)
   }()
}