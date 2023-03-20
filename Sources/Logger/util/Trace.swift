import Foundation

public class Trace {
   /**
    * To make it work you must set the "DEBUG" symbol, set it in the "Swift Compiler - Custom Flags" section, "Other Swift Flags" line.
    * - Remark: You add the DEBUG symbol with the -D DEBUG entry.
    * - Remark: From here: https://stackoverflow.com/questions/41974883/how-to-print-out-the-method-name-and-line-number-in-swift
    * - Remark: there is also: columnNumber: Int = #column -> The column number in which it begins.
    * ## Example:
    * func myFunction() {
    *    Trace.trace("This msg") // Prints "This msg is called from function: myFunction in class: Test on line: 13"
    * }
    * - Parameters:
    *   - message: custom msg
    *   - file: The name of the file in which it appears.
    *   - function: The name of the declaration in which it appears.
    *   - line: The line number on which it appears.
    */
   public static func trace(_ message: String, file: String = #file, function: String = #function, line: Int = #line ) -> String {
		let fileName = (file as NSString).lastPathComponent // file path isn't imp
      let className = fileName.split(separator: ".").dropLast()
	   return "\(message) is called from function: \(function) in class: \(className) on line: \(line)"
	}
   /**
    * Outputs: "FileManger.save" or "NetManager.connect" etc
    */
   public static func trace(file: String = #file, function: String = #function) -> String {
      let fileName = (file as NSString).lastPathComponent // file path isn't imp
      var className: String = "\(fileName.split(separator: ".").dropLast())"
      className.trim(left: "[\"", right: "\"]")
//      let functionName = function.removeSuffix(suffix: "()")
      return "\(className).\(function)"
   }
}
/**
 * String ext
 */
extension String {
   /**
    * trim left and right
    */
   mutating fileprivate func trim(left: String, right: String) {
      self = removePrefix(prefix: left)
      self = removeSuffix(suffix: right)
   }
   /**
    * Removes the first occurence of the the prefix
    */
   fileprivate func removePrefix(prefix: String) -> String {
      guard self.hasPrefix(prefix) else { return self }
      return "\(self.dropFirst(prefix.count))"
   }
   /**
    * Removes suffix from string
    */
   fileprivate func removeSuffix(suffix: String) -> String {
      guard self.hasSuffix(suffix) else { return self }
      return "\(self.dropLast(suffix.count))"
   }
}
