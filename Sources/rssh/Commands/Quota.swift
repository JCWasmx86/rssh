import ArgumentParser

struct Quota: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "quota", abstract: "List account quotas")
  public func cmd(pwd: String, home: String) -> String {
    return "quota"
  }
}
