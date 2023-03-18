import Foundation
/**
 * Different log cases available for print.
 * - Remark: Alt emojies: ☠️ 📣 ⚠️ 🚧 ☣️ 🚨 🟣 🟢 🟤 🟡
 * - Remark: Alt titles: alert, info, success, event, debug, notice, warning, verbose, emergency, severe
 * - Fixme: ⚠️️ Emojies could be customizable: `static var warningEmojiSymbol = "" static var debugEmojiSymbol = "" static var errorEmojiSymbol = ""` etc
 */
public enum LogLevel: String, CaseIterable { // Severity: fatal, critical, normal etc
   /**
    * A non-recoverable error occurred (App crashes, fatal)
    * - Remark: Data is potentially corrupted, critical, potential fatal
    */
   case error = "🔴"
   /**
    * An error occurred but it is recoverable (UX breaks)
    */
   case warning = "🟠"
   /**
    * Regular system event of interest
    * - Remark: Summary information of a context, transitions, button taps, cell selection etc
    */
   case debug = "🔵"
}
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
