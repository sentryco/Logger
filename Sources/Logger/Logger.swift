import Foundation

/**
 * Logger class for logging events, errors, warnings, and information.
 */
public final class Logger {}
public typealias Log = Logger // Alias for Logger, useful when os.Logger is available from iOS 14 onwards

/**
 * Extension to add configuration properties to the Logger class
 */
extension Logger {
   /**
    * Configuration for the log format
    */
   public static var config: LogConfig = .full

   /**
    * Configuration for the log level and tag
    */
   public static var mode: LogMode = .everything

   /**
    * Configuration for the log type: console, file, or custom
    * - Remark: Currently, only one type is supported at a time
    */
   public static var type: LogType = .console

   /**
    * Method to set up the logger with specific configuration, mode, and type
    * - Parameters:
    *   - config: Configuration for the log format
    *   - mode: Configuration for the log level and tag
    *   - type: Configuration for the log type
    */
   public static func setup(config: LogConfig, mode: LogMode, type: LogType) {
      Self.config = config
      Self.mode = mode
      Self.type = type
   }
}

/**
 * Extension to add logging commands to the Logger class
 * - Fixme: ⚠️️ Add later: add class and line to end of msg aka the code that is in Trace.trace
 */
extension Logger {
   /**
    * Method to log regular app events, useful for understanding other critical events
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
    * Logger.warn(text: "BPManager.connect error: \(error.localDescription)", type: .net)
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
      guard mode.tag.contains(where: { $0 == tag }) else { return } // filter on tag
      let text: String = text(msg, level: level, tag: tag) // get formatted print output
      type.log(msg: text, level: level, tag: tag) // log to console or file
   }

   /**
    * Method to format the log output
    * - Parameters:
    *   - msg: Message to log
    *   - level: Level of the log (e.g., info, debug, warning, error)
    *   - tag: Type of logging, e.g., payment, network, database, etc.
    */
   fileprivate static func text(_ msg: String, level: LogLevel, tag: LogTag) -> String {
      let level: String = config.useVerboseTypeText ? "\(level.title) \(level.rawValue)" : "\(level.rawValue)"
      var text: String = "[\(level)]"
      let date: String = config.dateFormatter.string(from: .init())
      if config.showDate { text += " [\(date)]" }
      return "\(text) ➞ \(tag.rawValue) \(msg)"
   }
}