import ArgumentParser

struct Echo: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "echo", abstract: "Write arguments to the standard output")
  @Flag(name: [.customShort("n")], help: "Do not print the trailing newline character.")
  var n: Bool = false
  @Argument(help: "Strings")
  var strings: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "echo "
    if n {
      ret += "-n "
    }
    for string in strings {
      ret += string
      ret += " "
    }
    return ret
  }
}
