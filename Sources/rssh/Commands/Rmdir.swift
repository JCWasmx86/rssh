import ArgumentParser

struct Rmdir: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "rmdir",
    abstract: "Remove directories"
  )
  @Flag(name: [.customShort("p")], help: "") var p: Bool = false
  @Flag(
    name: [.customShort("v")],
    help: "Be verbose when creating directories, listing each directory as it is removed."
  ) var v: Bool = false
  @Argument(help: "Files") var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "rmdir "
    if v { ret += "-v " }
    if p { ret += "-p " }

    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
