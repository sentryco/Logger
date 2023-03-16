import Foundation
import FileSugar
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
   public static var isNewLogSession: Bool = false
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
