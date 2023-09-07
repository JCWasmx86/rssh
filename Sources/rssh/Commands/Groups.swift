import ArgumentParser

struct Groups: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "groups", abstract: "Show group memberships")
  public func cmd(pwd: String, home: String) -> String {
    return "groups"
  }
}
