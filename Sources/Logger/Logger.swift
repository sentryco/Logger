import Foundation
/**
 * Logger
 */
public final class Logger {}
/**
 * Commands
 * - Fixme: ⚠️️ Add later: add class and line to end of msg
 */
extension Logger {
   /**
    * Regular app event which can be used to decipher other more critical events
    * ## Example:
    * Logger.error(text: "BPManager.connect error: \(error.localDescription)", type: .net)
    * Output: [🟠 Debug] [23-12-24 22:00:45] ➞ 📡 Network.connect error: Wifi not turned on
    */
   public static func debug(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .debug, tag: tag)
   }
   /**
    * Semi critical, but can be ignoered. Doesn't break anything. is recoverable
    */
   public static func warn(_ msg: String, tag: LogTag =  .other) {
      log(msg, level: .warning, tag: tag)
   }
   /**
    * Breaks something, but might be recoverable on subsequent attempt etc
    * ## Examples:
    * Logger.error("MainView - init")
    */
   public static func error(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .error, tag: tag)
   }
}
/**
 * Private helpers
 */
extension Logger {
   /**
    * Low level log call
    */
   fileprivate static func log(_ msg: String, level: LogLevel, tag: LogTag) {
      guard mode.level.contains(where: { $0 == level }) else { return } // Filter level
      guard mode.tag.contains(where: { $0 == tag }) else { return } // filter on tag
      let text: String = text(msg, level: level) // get formated print output
      type.log(msg: text, level: level, tag: tag) // log to consol or file
   }
   /**
    * Format log output
    */
   fileprivate static func text(_ msg: String, level: LogLevel) -> String {
      let level: String = config.useVerboseTypeText ? "\(level.title) \(level.rawValue)" : "\(level.rawValue)"
      var text: String = "[\(level)]"
      let date: String = config.dateFormatter.string(from: Date())
      if config.showDate { text += " [\(date)]" }
      return "\(text) ➞ \(msg)"
   }
}
/**
 * Const
 */
extension Logger {
   /**
    * Format config
    */
   public static var config: LogConfig = .full
   /**
    * Level and Tag
    */
   public static var mode: LogMode = .everything
   /**
    * Consol, file or custom
    * - Remark: We support only one type at the time for now
    */
   public static var type: LogType = .console
}
