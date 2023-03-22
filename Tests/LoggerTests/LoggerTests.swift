import XCTest
import Logger
import FileSugar

final class LoggerTests: XCTestCase {
   func testExample() throws {
      Self.log2consol()
      Self.log2CustomOutput()
      Self.log2file()
      Self.testTrace()
      // - Fixme: ⚠️️ Begin Telemetry lib for GA
   }
}
extension LoggerTests {
   /**
    * Write to console with a few different modes
    */
   fileprivate static func log2consol() {
      Swift.print("log2consol")
      // Print text format
      Logger.config = .plain // .full
      // Output transport
      Logger.type = .console // .file(filePath)
      // Levels and tags
      Logger.mode = .everything // .nothing, .essential
      Logger.debug("MainView.test()", tag: .ui)
      Logger.config = .full
      Logger.mode = .essential
      Logger.debug("MainView.test()", tag: .ui) // this doesnt show in essential mode
      Logger.warn("UserDef not saved", tag: .file) // this shows in essential mode
      Logger.config = .full // show all details
      Logger.error("Wrong format when trying to save", tag: .file) // this shows in essential mode
   }
   /**
    * We can call GA (google analytics) or firebase crashalytics here
    * - Remark: We could also filter on tag. To focus on data, network, security etc
    */
   fileprivate static func log2CustomOutput() {
      Swift.print("log2CustomOutput")
      let onLog: LogType.OnLog = { msg, level, _ in
         if [LogLevel.error, .warning].contains(where: { $0 == level }) {
            Swift.print(msg) // Only prints warning and error, simulates call to GA etc
         }
      }
      Logger.type = .custom(onLog) // Add the custom output closure to the logger
      Logger.warn("Uh-Oh something went wrong") // Prints
      Logger.error("Unsupported format, bail") // Prints
      Logger.debug("Entered backround") // Does not print
   }
   /**
    * Write to file, assert content
    * - Fixme: ⚠️️ we could omit date and assert correct content of file
    */
   fileprivate static func log2file() {
      Swift.print("log2file")
      let tempFilePath = "\(NSTemporaryDirectory())/log.txt"
      Logger.type = .file(tempFilePath)
      Logger.debug("Test")
      Swift.print("LogType.tempFilePath:  \(tempFilePath)")
      let fileExists = FileAsserter.exists(path: tempFilePath)
      Swift.print("fileExists\(fileExists ? "✅" : "🚫")")
      XCTAssertTrue(fileExists)
   }
   /**
    * do Trace
    */
   fileprivate static func testTrace() {
      Swift.print("testTrace")
      func myFunction() {
         Swift.print(Trace.trace("This msg"))
      }
      myFunction() // Prints "This msg is called from function: myFunction in class: Test on line: 13"
   }
}
