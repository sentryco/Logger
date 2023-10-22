import Foundation// Import the Foundation framework for basic data types and operations
import FileSugar// Import the FileSugar framework for file system operations
/**
 * LogType
 * This enum defines the different types of logging that can be performed.
 * - Fixme: ⚠️️ Add later `.os`, `.sys`, (syslog, and oslog)
 */
public enum LogType {
   /**
    * Console logging type.
    * This case is used when the logs need to be printed to the console.
    * - Fixme: ⚠️️ Rename to print? and then use console for .os etc ? or remove?
    */
   case console
   /**
    * File logging type.
    * This case is used when the logs need to be written to a file.
    * - Remark: Temp: "\(NSTemporaryDirectory())/log.txt"
    * - Remark: Home: "\(NSHomeDirectory())/log.txt"
    */
   case file(_ filePath: String)
   /**
    * Custom logging type.
    * This case is used when the logs need to be handled by a custom function.
    * - Fixme: ⚠️️ Add example
    */
   case custom(_ onLog: OnLog)
}

/**
 * LogType extension for logging helper.
 * This extension provides a function to log messages based on the LogType.
 */
extension LogType {
   /**
    * Log to type
    * This function logs the message to the specified log type.
    * - Parameters:
    *   - msg: Message to print
    *   - level: Severity level to filter on etc
    *   - tag: Tag type to filter on etc
    */
   internal func log(msg: String, level: LogLevel, tag: LogTag) {
      switch self {
      case .console: // Console
         Swift.print(msg)
      case let .file(filePath): // File
         Self.writeToFile(string: msg, filePath: filePath)
      case let .custom(onLog): // Custom
         onLog(msg, level, tag) // Call closure
      }
   }
}
/**
 * LogType extension for custom logging.
 * This extension provides a typealias for a closure that can be used for custom logging.
 */
extension LogType {
   /**
    * Closure hook typealias for custom output
    * This typealias defines a closure that can be used for custom logging.
    * - Remark: It could be a good idea to filter calls if device is in the background / standby via: `UIApplication.shared.applicationState == .active`
    * - Fixme: ⚠️️ document each parameter
    */
   public typealias OnLog = (_ msg: String, _ level: LogLevel, _ tag: LogTag) -> Void
}
/**
 * LogType extension for file logging.
 * This extension provides a function to write logs to a file.
 */
extension LogType {
   /**
    *  Indicates if a new log session was started.
    */
   public static var isNewLogSession: Bool = false
   /**
    * Write text to file
    * This function writes a string to a file.
    * - Remark: By using temp folder, the file is removed automatically at some point
    * - Remark: Logs might be lost in temp folder if automation needs to kill the app.
    * - Fixme: ⚠️️ Maybe auto-create new file if size exceeds 3MB etc, temp folder do remove content if it gets too big etc I think, so add this later etc
    * - Parameters:
    *   - string: Make sure to add \n to end
    *   - filePath: Destination file path, usually temp folder path etc
    */
   public static func writeToFile(string: String, filePath: String) {
      var content: String = ""
      if !FileAsserter.exists(path: filePath) { // Assert if filePath doesn't exist
         FileModifier.write(filePath, content: "New file created" + "\n") // Create new file if non exists
      }
      if isNewLogSession == false { // Indicates new app session
         content += "New session started" + "\n"
         isNewLogSession = true // only trigger once per app session
      }
      content += string + "\n" // Add string
      FileModifier.append(filePath, text: content) // Append content to end of file
   }
}
