import Foundation
/**
 * Noise level in the console
 * ## Example:
 * let mode: LogMode = .init(tag: LogTag.allCases.filter { $0 != .net && $0 != .db && $0 != .security }, level: LogLevel.allCases)
 */
public struct LogMode {
   public let tag: TagFilter
   public let level: LevelFilter
   public init(tag: TagFilter, level: LevelFilter) {
      self.tag = tag
      self.level = level
   }
}
/**
 * Const
 * - Fixme: ⚠️️ is this needed? Seems like we use custom setup most of the time anyways, remove? I guess it can be nice to get started? see example use cases etc?
 * - Fixme: ⚠️️ add examples to each type?
 */
extension LogMode {
   /**
    * Log error, warning, info
    */
   public static let everything: LogMode = .init(tag: LogTag.allCases, level: LogLevel.allCases)
   /**
    * Log nothing (so we can use regular print for stuff etc)
    */
   public static let nothing: LogMode = .init(tag: [], level: [])
   /**
    * Moderate
    */
   public static let essential: LogMode = .init(tag: LogTag.allCases, level: [.warning, .error])
}
/**
 * TagFilter
 * ## Examples:
 * LogTag.allCases.filter { $0 != .net && $0 != .db && $0 != .security }
 */
public typealias TagFilter = [LogTag] // [.db, .net, .file, .ui, .security, .other]
/**
 * LevelFilter
 * ## Examples:
 * LogLevel.allCases.filter({ $0 != .info })
 */
public typealias LevelFilter = [LogLevel] // [.error, .warning, .info, .critical]
