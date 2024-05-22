import Foundation
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
