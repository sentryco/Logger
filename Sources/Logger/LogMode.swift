import Foundation
/**
 * Noise level in the console
 */
public struct LogMode {
   let tag: TagFilter
   let level: LevelFilter
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
typealias TagFilter = [LogTag] // [.db, .net, .file, .ui, .security, .other]
typealias LevelFilter = [LogLevel] // [.error, .warning, .info, .critical]
