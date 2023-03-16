import Foundation
/**
 * Custom
 */
extension LogType {
   /**
    * Closure hock typealias for custom output
    */
   public typealias OnLog = (_ msg: String, _ level: LogLevel, _ tag: LogTag) -> Void
}
