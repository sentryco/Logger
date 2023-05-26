import Foundation
/**
 * Remark: it's nice to turn of network sometimes etc, as its annoying and verbose.
 * - Fixme: ⚠️️ We can make emojis customizable, see note in LogLevel
 * - Fixme: ⚠️️ add appstore? or is payment good enough?
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

