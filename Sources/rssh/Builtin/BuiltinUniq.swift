import ArgumentParser
import Foundation

struct BuiltinUniq: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "uniq",
    abstract: "Report or omit repeated lines.")

  @Flag(name: .shortAndLong, help: "Suppress repeated lines.")
  var unique: Bool = false

  @Flag(
    name: [.customShort("d"), .customLong("repeated")],
    help: "Suppress repeated lines, but show all lines in groups of identical lines.")
  var repeated: Bool = false

  @Flag(
    name: .shortAndLong,
    help: "Ignore differences in case when comparing")
  var ignoreCase: Bool = false

  @Flag(
    name: .shortAndLong,
    help:
      "Count the number of occurrences of each line, and write this count and a single copy of each line to the output."
  )
  var count: Bool = false

  func apply(stdin: String) throws -> String {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/uniq")
    task.arguments = []
    if self.unique {
      task.arguments!.append("-u")
    }
    if self.repeated {
      task.arguments!.append("-d")
    }
    if self.count {
      task.arguments!.append("-c")
    }
    let stdinPipe = Pipe()
    stdinPipe.fileHandleForWriting.write(stdin.data(using: .utf8)!)
    stdinPipe.fileHandleForWriting.closeFile()
    task.standardInput = stdinPipe

    let stdoutPipe = Pipe()
    task.standardOutput = stdoutPipe

    try task.run()
    task.waitUntilExit()

    let stdoutData = stdoutPipe.fileHandleForReading.readDataToEndOfFile()
    return String(data: stdoutData, encoding: .utf8)!
  }
}
