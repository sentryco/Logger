![mit](https://img.shields.io/badge/License-MIT-brightgreen.svg)
![platform](https://img.shields.io/badge/Platform-iOS/macOS-blue.svg)
![Lang](https://img.shields.io/badge/Language-Swift%205-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift)
[![Tests](https://github.com/sentryco/Logger/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/Logger/actions/workflows/Tests.yml)
[![codebeat badge](https://codebeat.co/badges/1b701174-9272-4fc9-9de4-3e12af2094d6)](https://codebeat.co/projects/github-com-sentryco-logger-main)

# 🔍 Logger

> Simple console logger

### Features
- 4 levels of severity (🔴 error, 🟠 warning, 🔵️ debug, 🟣 info)
- 9 tag types (📡 network, 🗄 database, 🖥 UI, 💾 file, 🔑 security, 🛍 payment, ⚙️ system, 🧰 util, 📝 other)
- Output to **consol**, **file**, or a **custom** end-point like Google analytics or Firebase crashalytics etc (Use Telemetry for GA)

### Why Logger?
- Debugging complex apps efficiently requires filtering to prevent console clutter.
- Fixing network bugs becomes easier when UI and DB logging can be turned off.
- Sending errors to endpoints like Google Analytics or Firebase Crashlytics is beneficial.

### Logging format:
```swift
Logger.debug(text: "Network.connect - connection established successfully", type: .net)
// Output: [🔵️ Debug] [23-12-24 22:00:45] ➞ 📡 Network.connect: connection established successfully
Logger.warning(text: "Network.connect \(error.localDescription)", type: .net)
// Output: [️🟠 Warning] [23-12-24 22:00:45] ➞ 📡 Network.connect: Wifi not turned on
Logger.error(text: "Network.process-data \(error.localDescription)", type: .net)
// Output: [🔴 Error] [23-12-24 22:00:45] ➞ 📡 Network.process-data: Decoding was unsuccessful. Nothing was saved
```

### Configure:
```swift
// Print text format
Logger.config = .plain // .full
// Output transport
Logger.type = .console // .file(filePath), .custom({ level, tag, msg in })
// Levels and tags
Logger.mode = .everything // .nothing, .essential
// Or use this convenient one-liner:
Logger.setup(config: .plain, mode: .everything, type: .console)
```

### Add custom log end-point like GA or Firebase crashalytics
```swift
let onLog: LogType.OnLog = { msg, level, _ in
   if [LogLevel.error, .warning].contains(where: { $0 == level }) {
      Swift.print(msg) // Only prints warning and error, replace w/ call to GA etc
   }
}
Logger.type = .custom(onLog) // Add the custom output closure to the logger
Logger.warn("Uh-Oh something went wrong") // Prints
Logger.error("Unsupported format, bail") // Prints
Logger.debug("Entered backround") // Does not print
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
