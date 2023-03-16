import Foundation
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
