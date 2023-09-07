import ArgumentParser

struct Df: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "df", abstract: "Display free disk space")
  @Option(name: [.customShort("t")], help: "")
  var t: String?
  @Flag(name: [.customShort("a")])
  var a: Bool = false
  @Flag(name: [.customShort("b")])
  var b: Bool = false
  @Flag(name: [.customShort("c")])
  var c: Bool = false
  @Flag(name: [.customShort("g")])
  var g: Bool = false
  @Flag(name: [.customShort("h")])
  var h: Bool = false
  @Flag(name: [.customShort("H")])
  var H: Bool = false
  @Flag(name: [.customShort("i")])
  var i: Bool = false
  @Flag(name: [.customShort("k")])
  var k: Bool = false
  @Flag(name: [.customShort("l")])
  var l: Bool = false
  @Flag(name: [.customShort("m")])
  var m: Bool = false
  @Flag(name: [.customShort("n")])
  var n: Bool = false
  @Flag(name: [.customShort("P")])
  var P: Bool = false
  @Flag(name: [.customShort("T")])
  var T: Bool = false
  @Flag(name: [.customShort(",")])
  var comma: Bool = false

  @Argument(help: "Files or filesystems")
  var paths: [String] = []

  public func cmd(pwd: String, home: String) -> String {
    var ret = "df "
    if t != nil { ret += ("-t " + t! + " ") }
    if a { ret += "-a " }
    if b { ret += "-b " }
    if c { ret += "-c " }
    if g { ret += "-g " }
    if h { ret += "-h " }
    if H { ret += "-H " }
    if i { ret += "-i " }
    if k { ret += "-k " }
    if l { ret += "-l " }
    if m { ret += "-m " }
    if n { ret += "-n " }
    if P { ret += "-P " }
    if T { ret += "-T " }
    if comma { ret += "-, " }
    for file in self.paths {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
