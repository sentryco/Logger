import Foundation

/**
 * This file contains the LogTag enum which is used to categorize logs.
 * Each case in the enum represents a different category of logs.
 * The raw value of each case is an emoji that visually represents the category.
 * Remark: It's nice to turn off network logs sometimes etc, as they can be annoying and verbose.
 * - Fixme: ⚠️️ We can make emojis customizable, see note in LogLevel
 * - Fixme: ⚠️️ Consider adding an appstore log category, or is payment good enough?
 */
public enum LogTag: String, CaseIterable {
   case db = "🗄" // Database logs
   case net = "📡" // Network logs
   case file = "💾" // File I/O logs
   case ui = "🖥" // UI logs
   case security = "🔑" // Security related logs
   case payment = "🛍" // Payment related logs
   case system = "⚙️" // System logs
   case util = "🧰" // Utility logs
   case other = "📝" // Other logs, for anything that doesn't fit into the above categories
   // - Fixme: ⚠️️ find a more generic icon for the 'other' category?
}