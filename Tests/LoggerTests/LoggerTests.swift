import XCTest
import Logger
import FileSugar

// LoggerTests class inherits from XCTestCase
final class LoggerTests: XCTestCase {
   // Test function that calls various logging methods
   func testExample() throws {
      Self.log2consol() // Logs to console
      Self.log2CustomOutput() // Logs to custom output
      // Self.log2file() // Logs to file
      Self.testTrace() // Tests trace functionality
      // TODO: Implement Telemetry library for Google Analytics
   }
}

extension LoggerTests {
   /**
    * Function to log messages to the console in different modes
    */
   fileprivate static func log2consol() {
      Swift.print("log2consol")
      // Set Logger configuration to plain text format
      Logger.config = .plain // .full
      // Set Logger output transport to console
      Logger.type = .console // .file(filePath)
      // Set Logger levels and tags
      Logger.mode = .everything // .nothing, .essential
      // Log a debug message with the UI tag
      Logger.debug("MainView.test()", tag: .ui)
      // Set the logger configuration to full
      Logger.config = .full
      // Set the logger mode to essential
      Logger.mode = .essential
      Logger.debug("MainView.test()", tag: .ui) // this doesn't show in essential mode
      Logger.warn("UserDef not saved", tag: .file) // this shows in essential mode
      Logger.config = .full // show all details
      Logger.error("Wrong format when trying to save", tag: .file) // this shows in essential mode
   }
   /**
    * Function to log messages to custom output like Google Analytics or Firebase Crashlytics
    * Note: We could also filter on tag to focus on data, network, security etc
    */
   fileprivate static func log2CustomOutput() {
      Swift.print("log2CustomOutput")
      let onLog: LogType.OnLog = { msg, level, _ in
         // Only print warning and error messages, simulating call to Google Analytics etc
         if [LogLevel.error, .warning].contains(where: { $0 == level }) {
            Swift.print(msg) 
         }
      }
      Logger.type = .custom(onLog) // Add the custom output closure to the logger
      Logger.warn("Uh-Oh something went wrong") // Prints
      Logger.error("Unsupported format, bail") // Prints
      Logger.info("App flow: move to front") // Prints
      Logger.debug("Entered backround") // Does not print
   }
   /**
    * Function to log messages to a file and assert its content
    * TODO: Omit date and assert correct content of file
    * TODO: Create the temp file if it doesn't already exist etc
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
    * Function to test trace functionality
    */
   fileprivate static func testTrace() {
      Swift.print("testTrace")
      func myFunction() {
         Swift.print(Trace.trace("This msg"))
      }
      myFunction() // Prints "This msg is called from function: myFunction in class: Test on line: 13"
   }
}