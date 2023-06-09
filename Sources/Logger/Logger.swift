import Foundation
/**
 * Logger
 */
public final class Logger {}
public typealias Log = Logger // Since apple has os.Logger from ios14 etc
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
   /**
    * Set logger construct
    * - Fixme: ⚠️️ Add example
    * - Parameters:
    *   - config: - Fixme: ⚠️️ Add doc
    *   - mode: - Fixme: ⚠️️ Add doc
    *   - type: - Fixme: ⚠️️ Add doc
    */
   public static func setup(config: LogConfig, mode: LogMode, type: LogType) {
      Self.config = config
      Self.mode = mode
      Self.type = type
   }
}
/**
 * Commands
 * - Fixme: ⚠️️ Add later: add class and line to end of msg aka the code that is in Trace.trace
 */
extension Logger {
   /**
    * Regular app event which can be used to decipher other more critical events
    * - Remark: This type is great for leaving trace code in libs and apps, and only activating them if we need to have more context while debugging
    * - Parameters:
    *   - msg: Trace + custom message
    *   - tag: type of loggin payment, network, database etc
    */
   public static func info(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .info, tag: tag)
   }
   /**
    * Use this to debug code that has bugs etc
    * - Remark: Use this for fixing bugs, should be temporary until it's solved etc
    * - Parameters:
    *   - msg: Trace + custom message
    *   - tag: type of loggin payment, network, database etc
    */
   public static func debug(_ msg: String, tag: LogTag = .other) {
      log(msg, level: .debug, tag: tag)
   }
   /**
    * Semi critical, but can be ignoered. Doesn't break anything. is recoverable
    * ## Example:
    * Logger.warn(text: "BPManager.connect error: \(error.localDescription)", type: .net)
    * Output: [🟠 Debug] [23-12-24 22:00:45] ➞ 📡 Network.connect error: Wifi not turned on
    * - Parameters:
    *   - msg: Trace + custom message
    *   - tag: type of loggin payment, network, database etc
    */
   public static func warn(_ msg: String, tag: LogTag =  .other) {
      log(msg, level: .warning, tag: tag)
   }
   /**
    * Breaks something, but might be recoverable on subsequent attempt etc
    * ## Examples:
    * Logger.error("MainView - init")
    * - Parameters:
    *   - msg: Trace + custom message
    *   - tag: type of loggin payment, network, database etc
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
    * - Parameters:
    *   - msg: - Fixme: ⚠️️ add doc
    *   - level: - Fixme: ⚠️️ add doc
    *   - tag: - Fixme: ⚠️️ add doc
    */
   fileprivate static func log(_ msg: String, level: LogLevel, tag: LogTag) {
      guard mode.level.contains(where: { $0 == level }) else { return } // Filter level
      guard mode.tag.contains(where: { $0 == tag }) else { return } // filter on tag
      let text: String = text(msg, level: level, tag: tag) // get formated print output
      type.log(msg: text, level: level, tag: tag) // log to consol or file
   }
   /**
    * Format log output
    * - Parameters:
    *   - msg: - Fixme: ⚠️️ add doc
    *   - level: - Fixme: ⚠️️ add doc
    *   - tag: - Fixme: ⚠️️ add doc
    */
   fileprivate static func text(_ msg: String, level: LogLevel, tag: LogTag) -> String {
      let level: String = config.useVerboseTypeText ? "\(level.title) \(level.rawValue)" : "\(level.rawValue)"
      var text: String = "[\(level)]"
      let date: String = config.dateFormatter.string(from: .init())
      if config.showDate { text += " [\(date)]" }
      return "\(text) ➞ \(tag.rawValue) \(msg)"
   }
}
