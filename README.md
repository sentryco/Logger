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

### Reasoning:
- Efficiently debugging complex apps, requires filtering, or else the console quickly becomes cluttered
- It is much easier to fix a network bug when we can turn of ui and db logging
- It is helpful to send errors to an endpoint like google analytics or firebase crashalytics

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

> **Warning**  
> Since iOS14+ Target apples own Logger class, write: `os.Logger`


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
- Print only works when debugging an app. When the app is built for running. Swift.print doesn't work anymore. Use file logging in release if needed
- Use the Telemetry for GA hock

### Todo:
- Maybe include the `Trace.trace()` call in log call so it can be toggled on and off 🤔
- Add the tag-type emoji to output just before msg etc
- Figure out how to log fatal crash? is it possible? exceptions? Research needed
- Do more stackoverflow search on logging best practice etc
- Add terminal color to formating text: https://github.com/sushichop/Puppy/blob/main/Sources/Puppy/LogColor.swift
- Add os support:  https://www.avanderlee.com/debugging/oslog-unified-logging/
- Try Firebase crashalytics in a demo project
- Add support for oslog in the framework. We currently support it in the ad-hock callback. Add this to unit test as well as instructions on Console.app usage and limitations etc
