import ArgumentParser

struct Find: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "find",
    abstract: "Walk a file hierarchy"
  )
  @Flag(name: [.customShort("H")]) var H: Bool = false
  @Flag(name: [.customShort("L")]) var L: Bool = false
  @Flag(name: [.customShort("P")]) var P: Bool = false
  @Flag(name: [.customShort("E")]) var E: Bool = false
  @Flag(name: [.customShort("X")]) var X: Bool = false
  @Flag(name: [.customShort("d")]) var d: Bool = false
  @Flag(name: [.customShort("s")]) var s: Bool = false
  @Flag(name: [.customShort("x")]) var x: Bool = false
  @Option(name: [.customShort("f")], help: "Path") var path: String?
  @Argument(help: "Paths") var paths: [String]
  // TODO: Expressions

  public func cmd(pwd: String, home: String) -> String {
    var ret = "find "
    if H { ret += "-H " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if E { ret += "-E " }
    if X { ret += "-X " }
    if d { ret += "-d " }
    if s { ret += "-s " }
    if x { ret += "-x " }
    if path != nil { ret += "-f " + path! + " " }
    for p in paths {
      ret += fixup(pwd: pwd, home: home, file: p)
      ret += " "
    }
    return ret
  }
}
