import Foundation
/**
 * Noise level in the console
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
 * Type
 */
public typealias TagFilter = [LogTag] // [.db, .net, .file, .ui, .security, .other]
public typealias LevelFilter = [LogLevel] // [.error, .warning, .info, .critical]