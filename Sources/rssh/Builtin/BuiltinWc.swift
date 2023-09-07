import ArgumentParser
import Foundation

struct BuiltinWc: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "wc",
    abstract: "Print newline, word, and byte counts for each file"
  )

  @Flag(name: [.customShort("c"), .customLong("bytes")], help: "Print the byte counts") var bytes:
    Bool = false
  @Flag(name: [.customShort("m"), .customLong("chars")], help: "Print the character counts")
  var chars: Bool = false

  @Flag(name: [.customShort("l"), .customLong("lines")], help: "Print the newline counts")
  var lines: Bool = false

  func apply(stdin: String) throws -> String {
    var output = ""
    let all = (!self.lines) && (!self.chars) && (!self.bytes)
    if self.lines || all {
      output += String(stdin.filter { $0 == "\n" }.count)
      output += " "
    }
    if self.chars || all {
      output += String(stdin.count)
      output += " "
    }
    if self.bytes || all {
      output += String(stdin.utf8.count)
      output += " "
    }
    return output.trimmingCharacters(in: .whitespaces)
  }
}
