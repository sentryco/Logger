import Foundation
/**
 * LogConfig is a structure that defines the configuration for logging.
 */
public struct LogConfig {
   public let showDate: Bool // Determines whether to include the timestamp at the beginning of the log.
   public let useVerboseTypeText: Bool // Determines whether to include text with the emoji in the log.
   public let dateFormat: String // Specifies the format of the date to be used in the log.
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
    * yyyy: The year with four digits.
    * MM: The month with two digits (01-12). 
    * dd: The day of the month with two digits (01-31). 
    * HH: The hour of the day with two digits in 24-hour format (00-23). 
    * mm: The minute of the hour with two digits (00-59). 
    * ss: The second of the minute with two digits (00-59).
    */
   public static let defaultDateFormat: String = "yyyy-MM-dd' 'HH:mm:ss"
   /**
    * A cached instance of `DateFormatter` to enhance performance.
    *
    * Creating a new `DateFormatter` instance for every date formatting operation can be resource-intensive.
    * This cached formatter ensures that a single instance is reused, minimizing overhead and improving efficiency.
    * The formatter is configured with the specified `dateFormat`, set to the UTC timezone, and uses the `en_US_POSIX` locale
    * to guarantee consistent date formatting regardless of the user's locale settings.
    */
   // Creating a new DateFormatter every time a date is formatted can be expensive. Caching the DateFormatter instance using a lazy property improves performance.
   private static var cachedDateFormatter: DateFormatter?
   /**
    * DateFormatter is used to format the date in the log.
    * - Descriptino: It uses the dateFormat specified in the LogConfig, sets the timezone to UTC, and sets the locale to "en_US_POSIX".
    * - Note: The UTC in the selected code refers to Coordinated Universal Time, which is a time standard that is used as a basis for timekeeping around the world. It is also known as Greenwich Mean Time (GMT) or Zulu Time (Z). UTC is a time zone that is not affected by daylight saving time or other local time adjustments, and it is used as a reference time for many different applications, including computer systems, aviation, and international communications. 
    * - Note: In the context of the LogConfig struct, the UTC time zone is used to ensure that the log messages are timestamped consistently regardless of the local time zone of the user or the system running the logger.
    * - Note: The selected code en_US_POSIX is a locale identifier that specifies the POSIX locale with US English language settings. The POSIX locale is a standard locale that defines the behavior of C programs running on POSIX-compliant systems, and it is used as a basis for many other locales. The en_US_POSIX locale is often used in software development to ensure consistent behavior across different platforms and to avoid issues with localization and internationalization.
    * - Note: In the context of the LogConfig struct, the en_US_POSIX locale is used to ensure that the date and time formatting is consistent regardless of the user's locale settings
    */
   var dateFormatter: DateFormatter {
      if let formatter = Self.cachedDateFormatter {
         return formatter
      } else {
         let format = DateFormatter()
         format.dateFormat = dateFormat
         format.timeZone = TimeZone(identifier: "UTC")
         format.locale = Locale(identifier: "en_US_POSIX")
         Self.cachedDateFormatter = format
         return format
      }
   }
}
// Extension of LogConfig for predefined configurations.
extension LogConfig {
   /**
    * Plain is a predefined LogConfig that does not show date and does not use verbose type text.
    * It uses the default date format.
    * ## Examples: 
    * Logger.configure(config: .plain)
    * Logger.log("Payment received successfully", level: .info, tag: .payment)
    * Output: [INFO] ➞ Payment received successfully
    */
   public static let plain: LogConfig = {
      .init(
         showDate: false, // Whether to include the timestamp in the log
         useVerboseTypeText: false, // Whether to include text with the emoji in the log
         dateFormat: defaultDateFormat // The date format to use. Default is "yyyy-MM-dd' 'HH:mm:ss".
      )
   }()
   /**
    * Full is a predefined LogConfig that shows date and uses verbose type text.
    * It uses the default date format.
    * ## Examples: 
    * Logger.configure(config: .full)
    * Logger.log("Payment received successfully", level: .info, tag: .payment)
    * Output: [INFO] [2022-08-01 12:00:00] ✅ payment Payment received successfully
    */
   public static let full: LogConfig = {
      .init(
         showDate: true, // Whether to include the timestamp in the log
         useVerboseTypeText: true, // Whether to include text with the emoji in the log
         dateFormat: defaultDateFormat // The date format to use. Default is "yyyy-MM-dd' 'HH:mm:ss".
      )
   }()
}
