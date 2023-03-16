import Foundation
/**
 * Helper
 */
extension LogType {
   /**
    * Log to type
    * - Parameters:
    *   - msg: Message to print
    *   - level: Severity level to filter on etc
    *   - tag: Tag type to filter on etc
    */
   internal func log(msg: String, level: LogLevel, tag: LogTag) {
      switch self {
      case .consol:  // Consol
         Swift.print(msg)
      case let .file(filePath): // File
         Self.writeToFile(string: msg, filePath: filePath)
      case let .custom(onLog): // Custom
         onLog(msg, level, tag) // Call clousure
      }
   }
}
