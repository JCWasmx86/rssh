import ArgumentParser
import Foundation

struct BuiltinGrep: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "grep", abstract: "Print lines that match patterns")

  @Flag(
    name: [.customShort("i"), .customLong("ignore-case")],
    help:
      "Ignore case distinctions"
  )
  var i: Bool = false
  @Flag(
    name: [.customShort("v"), .customLong("invert-match")],
    help:
      "Ignore case distinctions"
  )
  var v: Bool = false

  @Argument
  var regex: String

  public func apply(stdin: String) throws -> String {
    return try filterLines(
      s: stdin, regex: self.regex, invertMatch: self.v, caseInsensitive: self.i)
  }

  func filterLines(s: String, regex: String, invertMatch: Bool, caseInsensitive: Bool) throws
    -> String
  {
    let lines = s.split(separator: "\n")
    let options: NSRegularExpression.Options = caseInsensitive ? .caseInsensitive : []
    let pattern = try NSRegularExpression(pattern: regex, options: options)

    let filteredLines = lines.filter { line in
      let range = NSRange(line.startIndex..., in: line)
      let matches = pattern.firstMatch(in: String(line), options: [], range: range) != nil
      return invertMatch ? !matches : matches
    }
    return filteredLines.joined(separator: "\n") + "\n"
  }
}
