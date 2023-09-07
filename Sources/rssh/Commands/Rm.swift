import ArgumentParser

struct Rm: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(commandName: "rm", abstract: "Remove files")
  @Flag(name: [.customShort("f")]) var f: Bool = false
  @Flag(name: [.customShort("d")]) var d: Bool = false
  @Flag(name: [.customShort("P")]) var P: Bool = false
  @Flag(name: [.customShort("R")]) var R: Bool = false
  @Flag(name: [.customShort("r")]) var r: Bool = false
  @Flag(name: [.customShort("v")]) var v: Bool = false
  @Flag(name: [.customShort("W")]) var W: Bool = false
  @Flag(name: [.customShort("x")]) var x: Bool = false
  @Argument(help: "Files") var files: [String]
  public func cmd(pwd: String, home: String) -> String {
    var ret = "rm "
    if f { ret += "-f " }
    if d { ret += "-d " }
    if P { ret += "-P " }
    if R { ret += "-R " }
    if r { ret += "-r " }
    if v { ret += "-v " }
    if W { ret += "-W " }
    if x { ret += "-x " }
    for file in self.files {
      let fixed = fixup(pwd: pwd, home: home, file: file)
      if fixed == "/" || fixed == home {
        print("Won't delete", fixed, "as it is too important. No override is possible.")
        continue
      }
      ret += fixed
      ret += " "
    }
    return ret
  }
}
