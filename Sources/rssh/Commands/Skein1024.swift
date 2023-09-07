import ArgumentParser

struct Skein1024: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "skein1024",
    abstract: "Calculate a message-digest fingerprint (checksum) for a file"
  )
  @Option(name: [.customShort("c")], help: "") var c: String?
  @Option(name: [.customShort("s")], help: "") var s: String?
  // -p not applicable
  @Flag(name: [.customShort("q")]) var q: Bool = false
  @Flag(name: [.customShort("r")]) var r: Bool = false
  @Flag(name: [.customShort("t")]) var t: Bool = false
  @Flag(name: [.customShort("x")]) var x: Bool = false

  @Argument(help: "File") var files: [String] = []

  public func cmd(pwd: String, home: String) -> String {
    var ret = "skein1024 "
    if c != nil { ret += ("-c " + c! + " ") }
    if s != nil { ret += ("-s " + s! + " ") }
    if q { ret += "-q " }
    if r { ret += "-r " }
    if t { ret += "-t " }
    if x { ret += "-x " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
