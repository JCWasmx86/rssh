import ArgumentParser

struct BuiltinSort: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "sort",
    abstract: "Sort lines of text files"
  )

  @Flag(name: [.customShort("r"), .customLong("reverse")], help: "Reverse result of comparisons.")
  var r: Bool = false

  public func apply(stdin: String) throws -> String {
    return sortLines(s: stdin, ascending: !self.r)
  }
  func sortLines(s: String, ascending: Bool) -> String {
    let lines = s.split(separator: "\n")
    let sortedLines: [String]
    if ascending {
      sortedLines = lines.map(String.init).sorted()
    } else {
      sortedLines = lines.map(String.init).sorted { $0 > $1 }
    }
    return sortedLines.joined(separator: "\n") + "\n"
  }

}
