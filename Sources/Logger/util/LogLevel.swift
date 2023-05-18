import Foundation
/**
 * Different log cases available for print
 * - Remark: Alt emojies: ☠️ 📣 ⚠️ 🚧 ☣️ 🚨 🟢 🟤 🟡
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
    * Use this to find the needle in the haystack
    */
   case debug = "🔵"
   /**
    * Flow event. (Regular system event of interest)
    * - Remark: Turn this on if there is a bug and you need to see the flow that leads up to that bug etc. Filter out otherwise as it clogs up the log
    * - Remark: Summary information of a context, transitions, button taps, cell selection etc
    */
   case info = "🟣"
}
/**
 * Getter
 */
extension LogLevel {
   /**
    * Returns "Error", "Warning", "Info" or "Debug"
    */
   var title: String {
      String(describing: self).capitalized // First letter is uppercased
   }
}
