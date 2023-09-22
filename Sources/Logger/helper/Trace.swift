import Foundation

/*
* Trace class is used for debugging purposes. It provides methods to print out the method name, line number, and custom messages.
*/
public class Trace {
   /**
    * trace function prints a custom message along with the function name, class name, and line number where it is called.
    * - Note: To make it work you must set the "DEBUG" symbol, set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line.
    * - Remark: You add the DEBUG symbol with the -D DEBUG entry.
    * - Remark: From here: https://stackoverflow.com/questions/41974883/how-to-print-out-the-method-name-and-line-number-in-swift
    * - Remark: There is also: columnNumber: Int = #column -> The column number in which it begins.
    * ## Example:
    * func myFunction() {
    *    Trace.trace("This msg") // Prints "This msg is called from function: myFunction in class: Test on line: 13"
    * }
    * - Parameters:
    *   - message: Custom msg
    *   - file: The name of the file in which it appears
    *   - function: The name of the declaration in which it appears
    *   - line: The line number on which it appears
    */
   public static func trace(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) -> String {
		let fileName = (file as NSString).lastPathComponent // File path isn't imp
      let className = fileName.split(separator: ".").dropLast() // Get the class name by splitting the file name and dropping the last component
      return "\(message) is called from function: \(function) in class: \(className) on line: \(line)" // Return the formatted trace message
	}
   /**
    * trace function prints the function name along with the class name where it is called.
    * Outputs: "FileManger.save" or "NetManager.connect" etc
    */
   public static func trace(file: String = #file, function: String = #function) -> String {
      let fileName = (file as NSString).lastPathComponent // File path isn't imp
      var className: String = "\(fileName.split(separator: ".").dropLast())" // Split the file name by "." and drop the last component to get the class name
      className.trim(left: "[\"", right: "\"]") // let functionName = function.removeSuffix(suffix: "()")
      return "\(className).\(function)"// Return the formatted string that includes the class name and function name
   }
}
/**
 * Extension of String class to add utility functions.
 */
extension String {
   /**
    * trim function removes the specified prefix and suffix from the string.
    */
   fileprivate mutating func trim(left: String, right: String) {
      self = removePrefix(prefix: left) // Remove the left prefix from the trace message
      self = removeSuffix(suffix: right) // Remove the right suffix from the trace message
   }
   /**
    * removePrefix function removes the specified prefix from the string.
    */
   fileprivate func removePrefix(prefix: String) -> String {
      guard self.hasPrefix(prefix) else { return self } // Check if the trace message has the specified prefix
      return "\(self.dropFirst(prefix.count))" // Remove the prefix from the trace message and return the result
   }
   /**
    * removeSuffix function removes the specified suffix from the string.
    */
   fileprivate func removeSuffix(suffix: String) -> String {
      guard self.hasSuffix(suffix) else { return self } // Check if the trace message has the specified suffix
      return "\(self.dropLast(suffix.count))" // Remove the suffix from the trace message and return the result
   }
}