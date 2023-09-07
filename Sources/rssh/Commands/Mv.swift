import ArgumentParser

struct Mv: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(commandName: "mv", abstract: "Move files")
  @Flag(name: [.customShort("f")], help: "") var f: Bool = false
  // -i not applicable here
  @Flag(name: [.customShort("n")], help: "") var n: Bool = false
  @Flag(name: [.customShort("h")], help: "") var h: Bool = false
  @Flag(name: [.customShort("v")], help: "") var v: Bool = false
  @Argument(help: "Files") var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "mv "
    if f { ret += "-f " }
    if h { ret += "-h " }
    if n { ret += "-n " }
    if v { ret += "-v " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
