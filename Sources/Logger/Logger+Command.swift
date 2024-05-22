import Foundation
/**
 * Extension to add more direct logging commands to the Logger class
 * - Fixme: ⚠️️ Add later: add class and line to end of msg aka the code that is in Trace.trace
 */
extension Logger {
   /**
    * Method to log regular app events, useful for understanding other critical events
    * ## Examples:
    * Logger.info("Payment received successfully", tag: .payment)
    * Output: [INFO] [2022-08-01 12:00:00] ➞ payment Payment received successfully
    * - Parameters:
    *   - msg: Message to log, can include trace and custom message
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   public static func info(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .info, tag: tag)
   }
   /**
    * Method to log debug information, useful for identifying and fixing bugs
    * ## Example:
    * Logger.debug(text: "BPManager.connect error: \(error.localDescription)", type: .net)
    * Output: [🟠 Debug] [23-12-24 22:00:45] ➞ 📡 Network.connect error: Wifi not turned on
    * - Parameters:
    *   - msg: Message to log, can include trace and custom message
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   public static func debug(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .debug, tag: tag)
   }
   /**
    * Method to log warnings, useful for identifying semi-critical issues that don't break anything
    * ## Examples:
    * Logger.warn("Payment processing is taking longer than expected", tag: .other)
    * Output: [WARNING] [2022-08-01 12:00:00] ➞ other Payment processing is taking longer than expected
    * - Parameters:
    *   - msg: Message to log, can include trace and custom message
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   public static func warn(_ msg: String, tag: LogTag =  .other) {
      log(msg, level: .warning, tag: tag)
   }
   /**
    * Method to log errors, useful for identifying issues that break something but might be recoverable
    * - Parameters:
    *   - msg: Message to log, can include trace and custom message
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   public static func error(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .error, tag: tag)
   }
}
/**
 * Extension to add private helper methods to the Logger class
 */
extension Logger {
   /**
    * Low-level method to log a message with a specific level and tag
    * - Parameters:
    *   - msg: Message to log
    *   - level: Level of the log (e.g., info, debug, warning, error)
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   fileprivate static func log(_ msg: String, level: LogLevel, tag: LogTag) {
      guard mode.level.contains(where: { $0 == level }) else { return } // Filter level
      guard mode.tag.contains(where: { $0 == tag }) else { return } // Filter tag
      let text: String = text(msg, level: level, tag: tag) // Get formatted print output
      type.log(msg: text, level: level, tag: tag) // Log to console or file
   }
   /**
    * Method to format the log output
    * - Parameters:
    *   - msg: Message to log
    *   - level: Level of the log (e.g., info, debug, warning, error)
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   fileprivate static func text(_ msg: String, level: LogLevel, tag: LogTag) -> String {
      let level: String = config.useVerboseTypeText ? "\(level.title) \(level.rawValue)" : "\(level.rawValue)" // if the config flag is set to use verbose type text, add the title and raw value of the level, otherwise just add the raw value
      var text: String = "[\(level)]" // create the log message with the level enclosed in square brackets
      let date: String = config.dateFormatter.string(from: .init()) // get the current date and format it as a string
      if config.showDate { text += " [\(date)]" } // if the config flag is set to show the date, add it to the log message
      return "\(text) ➞ \(tag.rawValue) \(msg)" // return the formatted log message with the tag and message concatenated
   }
}
