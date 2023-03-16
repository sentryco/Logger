import Foundation
/**
 * Const
 */
extension Logger {
   /**
    * Format config
    */
   public static var config: LogConfig = .full
   /**
    * Level and Tag
    */
   public static var mode: LogMode = .everything
   /**
    * Consol, file or custom
    * - Remark: We support only one type at the time for now
    */
   public static var type: LogType = .consol
}

