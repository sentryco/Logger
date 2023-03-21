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
   case payment = "🛍"
   case system = "⚙️"
   case util = "🧰"
   case other = "📝"
}
extension LogTag {
   @available(*, deprecated, renamed: "payment")
   public static let finance: LogTag = .payment
}
