import Foundation
/**
 * `LogMode` is a structure that defines the noise level in the console.
 * It consists of two properties: `tag` and `level`.
 * `tag` is a filter for the type of logs to be displayed.
 * `level` is a filter for the severity of logs to be displayed.
 * ## Example:
 * let mode: LogMode = .init(tag: LogTag.allCases.filter { $0 != .net && $0 != .db && $0 != .security }, level: LogLevel.allCases)
 */
public struct LogMode {
   // The tag filter for the log mode
   public let tag: TagFilter 
   // The level filter for the log mode
   public let level: LevelFilter 
   /**
    * Initializes a new `LogMode` instance with the specified tag and level filters.
    * - Parameters:
    *   - tag: The tag filter to use.
    *   - level: The level filter to use.
    */
   public init(tag: TagFilter, level: LevelFilter) {
      self.tag = tag
      self.level = level
   }
}
/**
 * Extension of `LogMode` to define some constant log modes.
 * These can be used for quick setup or for common use cases.
 */
extension LogMode {
   /**
    * `everything` logs all types of logs at all levels.
    */
   public static let everything: LogMode = .init(tag: LogTag.allCases, level: LogLevel.allCases)
   /**
    * `nothing` does not log anything. This can be useful when you want to use regular print statements for debugging.
    */
   public static let nothing: LogMode = .init(tag: [], level: [])
   /**
    * `essential` logs all types of logs but only at warning and error levels.
    */
   public static let essential: LogMode = .init(tag: LogTag.allCases, level: [.warning, .error])
}

/**
 * `TagFilter` is a type alias for an array of `LogTag`.
 * It is used to specify the types of logs to be displayed.
 * ## Examples:
 * LogTag.allCases.filter { $0 != .net && $0 != .db && $0 != .security }
 */
public typealias TagFilter = [LogTag] // [.db, .net, .file, .ui, .security, .other]
/**
 * `LevelFilter` is a type alias for an array of `LogLevel`.
 * It is used to specify the severity of logs to be displayed.
 * ## Examples:
 * LogLevel.allCases.filter({ $0 != .info })
 */
public typealias LevelFilter = [LogLevel] // [.error, .warning, .info, .critical]