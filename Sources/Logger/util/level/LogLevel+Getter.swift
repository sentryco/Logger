import Foundation
/**
 * Getter
 */
extension LogLevel {
   /**
    * Returns "Error", "Warning" or "Debug"
    */
   var title: String {
      String(describing: self).capitalized // First letter is uppercased
   }
}
