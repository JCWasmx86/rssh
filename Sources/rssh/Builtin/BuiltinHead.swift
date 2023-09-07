import ArgumentParser

struct BuiltinHead: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "head", abstract: "Output the first part of files")

  @Option(
    name: [.customShort("n"), .customLong("lines")],
    help:
      "Output the first NUM lines, instead of the last 10"
  )
  var n: UInt = 10

  public func apply(stdin: String) throws -> String {
    let arr = stdin.split(whereSeparator: \.isNewline)
    let upper = self.n > arr.count ? arr.count : Int(n)
    return arr[0..<upper].joined(separator: "\n") + "\n"
  }
}
