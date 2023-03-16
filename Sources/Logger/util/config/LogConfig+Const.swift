import Foundation
/**
 * Const
 */
extension LogConfig {
   /**
    * less noisy
    */
   public static let plain: LogConfig = .init(showDate: false, useVerboseTypeText: false, dateFormat: defaultDateFormat)
   /**
    * Full spectrum diagnostics
    */
   public static let full: LogConfig = .init(showDate: true, useVerboseTypeText: true, dateFormat: defaultDateFormat)
}
