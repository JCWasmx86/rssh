import ArgumentParser

struct BuiltinCat: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "cat", abstract: "Concatenate files and print on the standard output")

  public func apply(stdin: String) throws -> String {
    return stdin
  }
}
