import Foundation
/**
 * Remark: it's nice to turn of network sometimes etc, as its annoying and verbose.
 * - Fixme: ⚠️️ Maybe skip these and put these in log text if needed etc?
 * - Fixme: ⚠️️ We can make emojis customizable, see note in LogLevel
 */
public enum LogTag: String, CaseIterable {
   case db = "🗄"
   case net = "📡"
   case file = "💾"
   case ui = "🖥"
   case security = "🔑"
   case finance = "🛍"
   case system = "💻"
   case util = "⚙️"
   case other = "📝"
}
