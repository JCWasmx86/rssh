import ArgumentParser

struct Du: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "du", abstract: "Display disk usage statistics")
  @Option(name: [.customShort("t")], help: "")
  var t: String?
  @Option(name: [.customShort("d")], help: "")
  var d: Int?
  @Option(name: [.customShort("I")], help: "")
  var I: String?
  @Option(name: [.customShort("B")], help: "")
  var B: String?
  @Flag(name: [.customShort("A")])
  var A: Bool = false
  @Flag(name: [.customShort("H")])
  var H: Bool = false
  @Flag(name: [.customShort("L")])
  var L: Bool = false
  @Flag(name: [.customShort("P")])
  var P: Bool = false
  @Flag(name: [.customShort("a")])
  var a: Bool = false
  @Flag(name: [.customShort("c")])
  var c: Bool = false
  @Flag(name: [.customShort("g")])
  var g: Bool = false
  @Flag(name: [.customShort("h")])
  var h: Bool = false
  @Flag(name: [.customShort("k")])
  var k: Bool = false
  @Flag(name: [.customShort("l")])
  var l: Bool = false
  @Flag(name: [.customShort("m")])
  var m: Bool = false
  @Flag(name: [.customShort("n")])
  var n: Bool = false
  @Flag(name: [.customShort("r")])
  var r: Bool = false
  @Flag(name: [.customShort("s")])
  var s: Bool = false
  @Flag(name: [.customShort("x")])
  var x: Bool = false

  @Argument(help: "Files or filesystems")
  var paths: [String] = []

  public func cmd(pwd: String, home: String) -> String {
    var ret = "du "
    if d != nil { ret += ("-d " + d!.description + " ") }
    if B != nil { ret += ("-B " + B! + " ") }
    if I != nil { ret += ("-I " + I! + " ") }
    if t != nil { ret += ("-t " + t! + " ") }
    if A { ret += "-A " }
    if H { ret += "-H " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if a { ret += "-a " }
    if c { ret += "-c " }
    if g { ret += "-g " }
    if h { ret += "-h " }
    if k { ret += "-k " }
    if l { ret += "-l " }
    if m { ret += "-m " }
    if n { ret += "-n " }
    if r { ret += "-r " }
    if s { ret += "-s " }
    if x { ret += "-x " }
    for file in self.paths {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
