import ArgumentParser
import Foundation

struct BuiltinSed: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "sed",
    abstract: "Stream editor for filtering and transforming text"
  )
  @Argument(help: "Expression to apply") var expression: String
  @Flag(
    name: [.customShort("E"), .customLong("regex-extended")],
    help: "Use extended regular expressions"
  ) var E: Bool = false

  public func apply(stdin: String) throws -> String {
    return try applySedExpression(s: stdin, expression: self.expression, extended: self.E)
  }

  func applySedExpression(s: String, expression: String, extended: Bool) throws -> String {
    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/sed")
    task.arguments = (extended ? ["-E"] : []) + ["-e", expression]
    let stdinPipe = Pipe()
    stdinPipe.fileHandleForWriting.write(s.data(using: .utf8)!)
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
