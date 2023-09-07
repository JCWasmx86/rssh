import ArgumentParser

struct Id: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "id", abstract: "Return user identity")
  @Flag(name: [.customShort("A")])
  var A: Bool = false
  @Flag(name: [.customShort("G")])
  var G: Bool = false
  @Flag(name: [.customShort("M")])
  var M: Bool = false
  @Flag(name: [.customShort("P")])
  var P: Bool = false
  @Flag(name: [.customShort("a")])
  var a: Bool = false
  @Flag(name: [.customShort("c")])
  var c: Bool = false
  @Flag(name: [.customShort("g")])
  var g: Bool = false
  @Flag(name: [.customShort("n")])
  var n: Bool = false
  @Flag(name: [.customShort("p")])
  var p: Bool = false
  @Flag(name: [.customShort("r")])
  var r: Bool = false
  @Flag(name: [.customShort("u")])
  var u: Bool = false
  @Argument(help: "User")
  var user: String?

  public func cmd(pwd: String, home: String) -> String {
    var ret = "id "
    if A { ret += "-A " }
    if G { ret += "-G " }
    if M { ret += "-M " }
    if P { ret += "-P " }
    if a { ret += "-a " }
    if c { ret += "-c " }
    if g { ret += "-g " }
    if n { ret += "-n " }
    if p { ret += "-p " }
    if r { ret += "-r " }
    if u { ret += "-u " }
    if user != nil {
      ret += user!
    }
    return ret
  }
}
