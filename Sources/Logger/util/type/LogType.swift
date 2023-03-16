import Foundation
/**
 * LogType
 * - Fixme: ⚠️️ Add later `.os`, `.sys`, (syslog, and oslog)
 */
public enum LogType {
   /**
    * Print to console or not
    */
   case consol
   /**
    * Use FileStream lib to append to a diagnostics.log or log.txt
    * - Remark: FilePath: "\(FileManager.TempFolder.string)/log.txt"
    */
   case file(_ filePath: String)
   /**
    * Pull closure from a variable where we can adhock functinality
    */
   case custom(_ onLog: OnLog)
}
