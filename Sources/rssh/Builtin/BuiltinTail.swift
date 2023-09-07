import ArgumentParser

struct BuiltinTail: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "tail",
    abstract: "Output the last part of files"
  )

  @Option(
    name: [.customShort("n"), .customLong("lines")],
    help: "Output the last NUM lines, instead of the last 10"
  ) var n: UInt = 10

  public func apply(stdin: String) throws -> String {
    let arr = stdin.split(whereSeparator: \.isNewline)
    var lower = arr.count - Int(self.n)
    lower = lower < 0 ? 0 : lower
    return arr[lower..<arr.count].joined(separator: "\n") + "\n"
  }
}
