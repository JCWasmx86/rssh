import ArgumentParser

struct Mkdir: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "mkdir", abstract: "Make directories")
  @Flag(name: [.customShort("p")], help: "Create intermediate directories as required.")
  var p: Bool = false
  @Flag(
    name: [.customShort("v")],
    help: "Be verbose when creating directories, listing them as they are created.")
  var v: Bool = false
  @Option(
    name: [.customShort("m")],
    help: "Set the file permission bits of the final created directory to the specified mode.")
  var m: String?
  @Argument(help: "Files")
  var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "mkdir "
    if v { ret += "-v " }
    if p { ret += "-p " }
    if m != nil { ret += "-m " + m! + " " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
