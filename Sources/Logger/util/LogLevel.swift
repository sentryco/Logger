import Foundation
/**
 * This enum represents different log levels available for print.
 * Each log level is associated with an emoji for visual representation.
 * - Remark: Alternative emojis: ☠️ 📣 ⚠️ 🚧 ☣️ 🚨 🟢 🟤 🟡
 * - Remark: Alternative titles: alert, info, success, event, debug, notice, warning, verbose, emergency, severe
 * - Fixme: ⚠️️ Emojis could be customizable: `static var warningEmojiSymbol = "" static var debugEmojiSymbol = "" static var errorEmojiSymbol = ""` etc
 */
public enum LogLevel: String, CaseIterable { // Severity: fatal, critical, normal etc
   /**
    * Represents a non-recoverable error. This is typically used when the app crashes or encounters a fatal error.
    * - Remark: Data is potentially corrupted, critical, potential fatal
    */
   case error = "🔴"
   /**
    * Represents a recoverable error. This is typically used when the user experience breaks but the app can still function.
    */
   case warning = "🟠"
   /**
    * Represents a debug log. This is typically used for finding specific issues during development.
    */
   case debug = "🔵"
   /**
    * Represents an informational log. This is typically used for logging regular system events of interest.
    * - Remark: Turn this on if there is a bug and you need to see the flow that leads up to that bug etc. Filter out otherwise as it clogs up the log
    * - Remark: Summary information of a context, transitions, button taps, cell selection etc
    */
   case info = "🟣"
}
/**
 * This extension provides a getter for the log level title.
 */
extension LogLevel {
   /**
    * Returns the title of the log level, which can be "Error", "Warning", "Info" or "Debug".
    * The title is the string representation of the log level, with the first letter capitalized.
    */
   var title: String {
      String(describing: self).capitalized // First letter is uppercased
   }
}