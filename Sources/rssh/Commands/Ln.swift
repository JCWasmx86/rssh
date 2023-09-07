import ArgumentParser

struct Ln: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(commandName: "ln", abstract: "Link files")
  @Flag(name: [.customShort("F")], help: "") var F: Bool = false
  @Flag(name: [.customShort("L")]) var L: Bool = false
  @Flag(name: [.customShort("P")]) var P: Bool = false
  @Flag(name: [.customShort("f")]) var f: Bool = false
  @Flag(name: [.customShort("h")]) var h: Bool = false
  // -i not applicable
  @Flag(name: [.customShort("n")]) var n: Bool = false
  @Flag(name: [.customShort("s")]) var s: Bool = false
  @Flag(name: [.customShort("v")]) var v: Bool = false
  @Flag(name: [.customShort("w")]) var w: Bool = false
  @Argument(help: "Files") var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "ln "
    if F { ret += "-F " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if f { ret += "-f " }
    if h { ret += "-h " }
    if n { ret += "-n " }
    if s { ret += "-s " }
    if v { ret += "-v " }
    if w { ret += "-w " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    if self.files.count == 1 { ret += pwd }
    return ret
  }
}
