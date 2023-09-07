import ArgumentParser

struct Touch: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "touch",
    abstract: "Change file access and modification times"
  )
  @Option(name: [.customShort("A")], help: "") var A: String?
  @Option(name: [.customShort("d")], help: "") var d: String?
  @Option(name: [.customShort("t")], help: "") var t: String?
  @Flag(name: [.customShort("a")]) var a: Bool = false
  @Flag(name: [.customShort("c")]) var c: Bool = false
  @Flag(name: [.customShort("h")]) var h: Bool = false
  @Flag(name: [.customShort("m")]) var m: Bool = false
  @Flag(name: [.customShort("r")]) var r: Bool = false

  @Argument(help: "Files") var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "touch "
    if A != nil { ret += ("-A " + A! + " ") }
    if d != nil { ret += ("-d " + d! + " ") }
    if t != nil { ret += ("-t " + t! + " ") }
    if a { ret += "-a " }
    if c { ret += "-c " }
    if h { ret += "-h " }
    if m { ret += "-m " }
    if r { ret += "-r " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
