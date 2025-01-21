![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![platform](https://img.shields.io/badge/Platform-iOS/macOS-blue.svg)
![Lang](https://img.shields.io/badge/Language-Swift%205-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift)
[![Tests](https://github.com/sentryco/Logger/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/Logger/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/1b701174-9272-4fc9-9de4-3e12af2094d6)](https://codebeat.co/projects/github-com-sentryco-logger-main)

# 🔍 Logger

> Simple console logger

### Features
- Four levels of severity: 🔴 Error, 🟠 Warning, 🔵 Debug, 🟣 Info
- Nine tag types: 📡 Network, 🗄 Database, 🖥 UI, 💾 File, 🔑 Security, 🛍 Payment, ⚙️ System, 🧰 Utility, 📝 Other
- Output to **console**, **file**, or a **custom endpoint** like Google Analytics or Firebase Crashlytics

### Why Logger?
- Efficiently debug complex apps by filtering logs to avoid console clutter.
- Easily toggle logging for specific components like UI or database interactions.
- Send errors and warnings to external services like Google Analytics or Firebase Crashlytics for better monitoring.

### Logging format:
```swift
Logger.debug("Network.connect - connection established successfully", tag: .net)
// Output: [🔵 Debug] [2023-12-24 22:00:45] ➞ 📡 Network.connect: connection established successfully

Logger.warning("Network.connect \(error.localizedDescription)", tag: .net)
// Output: [🟠 Warning] [2023-12-24 22:00:45] ➞ 📡 Network.connect: Wi-Fi is not turned on

Logger.error("Network.processData \(error.localizedDescription)", tag: .net)
// Output: [🔴 Error] [2023-12-24 22:00:45] ➞ 📡 Network.processData: Decoding was unsuccessful. Nothing was saved
```

### Configure:
```swift
// Configure the logger output format
Logger.config = .plain  // Options: .plain (no date), .full (includes date and verbose level)

// Set the output transport method
Logger.type = .console  // Options: .console, .file(filePath: String), .custom(onLog: LogType.OnLog)

// Define the logging mode for levels and tags
Logger.mode = .everything  // Options: .everything (all logs), .nothing (disable logging), .essential (warnings and errors only)

// Convenient one-liner setup
Logger.setup(config: .full, mode: .essential, type: .console)
```

### Add custom log end-point like GA or Firebase crashalytics
```swift
// Define a custom logging function
let onLog: LogType.OnLog = { msg, level, tag in
    // Only send warnings and errors to the custom endpoint
    if [.error, .warning].contains(level) {
        sendToAnalytics(msg, level: level, tag: tag)
    }
}

// Set the logger to use the custom output
Logger.type = .custom(onLog)

Logger.warn("User session expired", tag: .security)  // This will be sent to the custom endpoint
Logger.error("Failed to save data", tag: .db)        // This will be sent to the custom endpoint
Logger.info("User opened settings", tag: .ui)        // This will not be sent
```

> [!NOTE]  
> Since iOS14+ Target apples own Logger class, write: `os.Logger`

### Logging to Console.app
If mesages in console.app only shows messages as private. Read the logger article on eon.codes on how to change that.

```swift
import os // Need to import os.Logger

let logger = os.Logger(subsystem: "co.acme.ExampleApp", category: "ExampleApp")
let onLog: LogType.OnLog = { msg, level, _ in
   logger.log("\(msg, privacy: .public)") // Reveals the redacted text from the message
}
Logger.type = .custom(onLog) // Add the custom output closure to the logger
Logger.info("Something happened") // Prints to Console.app (filter by category or subsystem)
```

### Tracing

 The `Trace` class can be combined with `Logger` to include function names, class names, and line numbers in your logs.

```swift
class Test {
   func myFunction() {
      Trace.trace("This msg")
   }
}
Test().myFunction() // Prints "This msg is called from function: myFunction in class: Test on line: 13"
```

### Trace + Logger
```swift
Logger.warn("\(Trace.trace() - error occured", tag: .net) - error occured") // Called inside NetManager.connect
// Prints: [️🟠 Warning] [23-12-24 22:00:45] ➞ 📡 NetManager.connect - error occured
```

### Gotchas
- Print only works when debugging an app. When the app is built for running, Swift.print doesn't work anymore. Use file logging in release if needed.
- Use the Telemetry for GA hook.

## Installation
Add the following line to your `Package.swift` file:

```swift
.package(url: "https://github.com/sentryco/Logger", branch: "main")
```

Then add `Logger` as a dependency for your targets:

```swift
.target(
    name: "MyTarget",
    dependencies: [
        .product(name: "Logger", package: "Logger"),
    ]
),
```

### Todo:
- Consider including the `Trace.trace()` call in log call so it can be toggled on and off
- Add the tag-type emoji to output just before the message
- Research how to log fatal crashes, if possible. Exception handling needs to be explored
- Conduct more research on logging best practices
- Add terminal color to formatting text: https://github.com/sushichop/Puppy/blob/main/Sources/Puppy/LogColor.swift
- Add native OS support:  https://www.avanderlee.com/debugging/oslog-unified-logging/
- Test Firebase Crashlytics in a demo project
- Add support for oslog in the framework. We currently support it in the ad-hoc callback. Add this to unit test as well as instructions on Console.app usage and limitations.
- Consider adding another log type called "important"
- Add usage gif exploring system console, google-analytics, xcode consol
- Add problem / solution to readme
- Add a note about apples OS.Logger. And its limitations.
- Add protocol oriented design: 

```swift
protocol LoggerProtocol {
    func log(message: String, level: LogLevel, tag: LogTag)
}

// Implementations
class ConsoleLogger: LoggerProtocol {
    func log(message: String, level: LogLevel, tag: LogTag) {
        Swift.print(message)
    }
}

class FileLogger: LoggerProtocol {
    // File logging implementation...
}
```
- Add console color codes: 

```swift
extension String {
    enum ConsoleColor: String {
        case red = "\u{001B}[0;31m"
        case orange = "\u{001B}[0;33m"
        case blue = "\u{001B}[0;34m"
        case purple = "\u{001B}[0;35m"
        case reset = "\u{001B}[0;0m"
    }

    func colored(_ color: ConsoleColor) -> String {
        return "\(color.rawValue)\(self)\(ConsoleColor.reset.rawValue)"
    }
}

// Apply Colors in Logging:

extension Logger {
    fileprivate static func formatMessage(_ msg: String, level: LogLevel, tag: LogTag) -> String {
        // Existing formatting code...
        var text = "[\(levelText)]"
        if config.showDate {
            let date = config.dateFormatter.string(from: Date())
            text += " [\(date)]"
        }
        text += " ➞ \(tag.rawValue) \(msg)"

        // Apply color based on log level
        switch level {
        case .error:
            text = text.colored(.red)
        case .warning:
            text = text.colored(.orange)
        case .debug:
            text = text.colored(.blue)
        case .info:
            text = text.colored(.purple)
        }

        return text
    }
}
```

- Add Native OS Logging Support (os.log)

```swift
import os

public enum LogType {
    // Existing cases...
    case osLog(OSLog = .default)
}

extension LogType {
    internal func log(msg: String, level: LogLevel, tag: LogTag) {
        switch self {
        // Existing cases...
        case let .osLog(logger):
            if #available(iOS 14.0, macOS 11.0, *) {
                logger.log("\(msg, privacy: .public)")
            } else {
                os_log("%{public}@", log: logger, type: .default, msg)
            }
        }
    }
}

// Configure logger to use osLog
Logger.type = .osLog()

// Log messages
Logger.info("Application started", tag: .system)

```

- Implement Exception Handling for Fatal Crashes


```swift
// Set Up Exception Handler:
func setUpExceptionHandler() {
    NSSetUncaughtExceptionHandler { exception in
        Logger.error("Uncaught exception: \(exception)", tag: .system)
    }
}
// Set Up Signal Handler:
import Darwin

func setUpSignalHandler() {
    signal(SIGABRT) { _ in
        Logger.error("Received SIGABRT signal", tag: .system)
    }
    signal(SIGILL) { _ in
        Logger.error("Received SIGILL signal", tag: .system)
    }
    // Add handlers for other signals as needed
}
// Call Handlers at App Launch:
// In AppDelegate or main entry point
func applicationDidFinishLaunching(_ application: UIApplication) {
    setUpExceptionHandler()
    setUpSignalHandler()
    // Other initialization code...
}
// Extend LogType:
public enum LogType {
    // Existing cases...
    case crashlytics
}
// Implement Crashlytics Logging:
extension LogType {
    internal func log(msg: String, level: LogLevel, tag: LogTag) {
        switch self {
        // Existing cases...
        case .crashlytics:
            Crashlytics.crashlytics().log(msg)
            if level == .error {
                let error = NSError(domain: Bundle.main.bundleIdentifier ?? "Logger", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
                Crashlytics.crashlytics().record(error: error)
            }
        }
    }
}
// Usage Example:
Logger.type = .crashlytics
Logger.error("Critical failure", tag: .system)

```

**Introduce a New Log Level "Important"**

**Description**: Add a new log level for messages that are more significant than `info` but not quite `warning`.

**Implementation**:

- **Add New Case in `LogLevel`**:

```swift
public enum LogLevel: String, CaseIterable {
    // Existing cases...
    case important = "🟢"
}
```

- **Add Title for the New Level**:

```swift
extension LogLevel {
    var title: String {
        switch self {
        // Existing cases...
        case .important:
            return "Important"
        }
    }
}
```
- **Add Method in `Logger+Command`**:

```swift
extension Logger {
    public static func important(_ msg: String, tag: LogTag = .other) {
        log(msg, level: .important, tag: tag)
    }
}
```

- **Usage Example**:

```swift
Logger.important("User achieved a significant milestone", tag: .achievement)
```


**Adopt Protocol-Oriented Design**

**Description**: Refactor the logger to use protocols, allowing for greater flexibility, easier testing, and adherence to SOLID principles.

**Implementation**:

- **Define `LoggerProtocol`**:

```swift
public protocol LoggerProtocol {
    func log(_ msg: String, level: LogLevel, tag: LogTag)
}
```

- **Create Concrete Implementations**:

```swift
public class ConsoleLogger: LoggerProtocol {
    public func log(_ msg: String, level: LogLevel, tag: LogTag) {
        print(msg)
    }
}

public class FileLogger: LoggerProtocol {
    private let filePath: String

    public init(filePath: String) {
        self.filePath = filePath
    }

    public func log(_ msg: String, level: LogLevel, tag: LogTag) {
        // Implement file writing logic here
    }
}
```

- **Modify `Logger` to Use `LoggerProtocol`**:

```swift
public final class Logger {
    public static var logger: LoggerProtocol = ConsoleLogger()
    // Modify log methods to use `logger.log(...)`
}
```

- **Usage Example**:
```
Logger.logger = FileLogger(filePath: "/path/to/log.txt")
Logger.info("This will be logged to a file")
```

**Add Support for Swift Concurrency (`async`/`await`)**

**Description**: Modernize the logger to be compatible with Swift's async/await concurrency model.

**Implementation**:

```swift
extension Logger {
    public static func logAsync(_ msg: String, level: LogLevel, tag: LogTag) async {
        await withCheckedContinuation { continuation in
            DispatchQueue.global(qos: .utility).async {
                log(msg, level: level, tag: tag)
                continuation.resume()
            }
        }
    }
}
Task {
    await Logger.logAsync("Asynchronous log message", level: .info, tag: .system)
}
```

**Description**: Ensure that logging is safe in multi-threaded environments, particularly when writing to shared resources like files.

**Implementation**:

- **Use Serial Dispatch Queues**:

```swift
extension LogType {
    private static let fileWriteQueue = DispatchQueue(label: "com.logger.fileWriteQueue")

    static func writeToFile(string: String, filePath: String) {
        fileWriteQueue.async {
            // File writing code...
        }
    }
}
```