import Foundation
import FileSugar
/**
 * LogType
 * - Fixme: ⚠️️ Add later `.os`, `.sys`, (syslog, and oslog)
 */
public enum LogType {
   /**
    * Print to console or not
    */
   case console
   /**
    * Use FileStream lib to append to a diagnostics.log or log.txt
    * - Remark: FilePath: "\(FileManager.TempFolder.string)/log.txt"
    */
   case file(_ filePath: String)
   /**
    * Pull closure from a variable where we can adhock functinality
    */
   case custom(_ onLog: OnLog)
}
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
      case .console:  // Consol
         Swift.print(msg)
      case let .file(filePath): // File
         Self.writeToFile(string: msg, filePath: filePath)
      case let .custom(onLog): // Custom
         onLog(msg, level, tag) // Call clousure
      }
   }
}

/**
 * Custom
 */
extension LogType {
   /**
    * Closure hock typealias for custom output
    */
   public typealias OnLog = (_ msg: String, _ level: LogLevel, _ tag: LogTag) -> Void
}
/**
 * File
 */
extension LogType {
   /**
    * Destination log file
    * - Remark: Optional name could be  // log.text
    */
   public static var tempFilePath: String = FileManager.default.temporaryDirectory.appendingPathComponent("diagnostics.log").path
   /**
    *  Idicates app was started again
    */
   public static var isNewLogSession = false
   /**
    * Write text to file
    * - Remark: By using temp folder, the file is removed automatically at some point
    * - Fixme: ⚠️️ Maybe auto-create new file if size excedes 3MB etc, temp folder do remove content if it gets to big etc I think, so add this later etc
    * - Parameters:
    *   - string: Make sure to add \n to end
    *   - filePath: Destination file path, usually temp folder path etc
    */
   public static func writeToFile(string: String, filePath: String) {
      var content: String = ""
      if !FileAsserter.exists(path: filePath) { // Assert if filePath doesn't exist
         FileModifier.write(filePath, content: content) // Create new file if non exists
      }
      FileModifier.append(filePath, text: content)
      if isNewLogSession == false { content += "New session started" + "\n" } // Indicates new app session
      content += string // Add string
      FileModifier.append(filePath, text: content) // Append content to end of file
      isNewLogSession = true
   }
}
