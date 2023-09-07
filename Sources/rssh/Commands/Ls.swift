import ArgumentParser

struct Ls: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "ls", abstract: "List directory contents")
  @Flag(name: [.customShort("A")], help: "")
  var A: Bool = false
  @Flag(name: [.customShort("B")], help: "")
  var B: Bool = false
  @Flag(name: [.customShort("C")], help: "")
  var C: Bool = false
  @Option(name: [.customShort("D")], help: "")
  var D: String?
  @Flag(name: [.customShort("F")], help: "")
  var F: Bool = false
  @Flag(name: [.customShort("G")], help: "")
  var G: Bool = false
  @Flag(name: [.customShort("H")], help: "")
  var H: Bool = false
  @Flag(name: [.customShort("I")], help: "")
  var I: Bool = false
  @Flag(name: [.customShort("L")], help: "")
  var L: Bool = false
  @Flag(name: [.customShort("P")], help: "")
  var P: Bool = false
  @Flag(name: [.customShort("R")], help: "")
  var R: Bool = false
  @Flag(name: [.customShort("S")], help: "")
  var S: Bool = false
  @Flag(name: [.customShort("T")], help: "")
  var T: Bool = false
  @Flag(name: [.customShort("U")], help: "")
  var U: Bool = false
  @Flag(name: [.customShort("W")], help: "")
  var W: Bool = false
  @Flag(name: [.customShort("Z")], help: "")
  var Z: Bool = false
  @Flag(name: [.customShort("a")], help: "")
  var a: Bool = false
  @Flag(name: [.customShort("b")], help: "")
  var b: Bool = false
  @Flag(name: [.customShort("c")], help: "")
  var c: Bool = false
  @Flag(name: [.customShort("d")], help: "")
  var d: Bool = false
  @Flag(name: [.customShort("f")], help: "")
  var f: Bool = false
  @Flag(name: [.customShort("g")], help: "")
  var g: Bool = false
  @Flag(name: [.customShort("h")], help: "")
  var h: Bool = false
  @Flag(name: [.customShort("i")], help: "")
  var i: Bool = false
  @Flag(name: [.customShort("k")], help: "")
  var k: Bool = false
  @Flag(name: [.customShort("l")], help: "")
  public var l: Bool = false
  @Flag(name: [.customShort("m")], help: "")
  var m: Bool = false
  @Flag(name: [.customShort("n")], help: "")
  var n: Bool = false
  @Flag(name: [.customShort("o")], help: "")
  var o: Bool = false
  @Flag(name: [.customShort("p")], help: "")
  var p: Bool = false
  @Flag(name: [.customShort("q")], help: "")
  var q: Bool = false
  @Flag(name: [.customShort("r")], help: "")
  var r: Bool = false
  @Flag(name: [.customShort("s")], help: "")
  var s: Bool = false
  @Flag(name: [.customShort("t")], help: "")
  var t: Bool = false
  @Flag(name: [.customShort("u")], help: "")
  var u: Bool = false
  @Flag(name: [.customShort("w")], help: "")
  var w: Bool = false
  @Flag(name: [.customShort("x")], help: "")
  var x: Bool = false
  @Flag(name: [.customShort("y")], help: "")
  var y: Bool = false
  @Flag(name: [.customShort("1")], help: "")
  var one: Bool = false
  @Flag(name: [.customShort(",")], help: "")
  var comma: Bool = false

  @Argument(help: "Files")
  var files: [String] = []

  public func cmd(pwd: String, home: String) -> String {
    var ret = "ls "
    if A { ret += "-A " }
    if B { ret += "-B " }
    if C { ret += "-C " }
    if D != nil { ret += ("-D " + D! + " ") }
    if F { ret += "-F " }
    if G { ret += "-G " }
    if H { ret += "-H " }
    if I { ret += "-I " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if R { ret += "-R " }
    if S { ret += "-S " }
    if T { ret += "-T " }
    if U { ret += "-U " }
    if W { ret += "-W " }
    if Z { ret += "-Z " }
    if a { ret += "-a " }
    if b { ret += "-b " }
    if c { ret += "-c " }
    if d { ret += "-d " }
    if f { ret += "-f " }
    if g { ret += "-g " }
    if h { ret += "-h " }
    if i { ret += "-i " }
    if k { ret += "-k " }
    if l { ret += "-l " }
    if m { ret += "-m " }
    if n { ret += "-n " }
    if o { ret += "-o " }
    if p { ret += "-p " }
    if q { ret += "-q " }
    if r { ret += "-r " }
    if s { ret += "-s " }
    if t { ret += "-t " }
    if u { ret += "-u " }
    if w { ret += "-w " }
    if x { ret += "-x " }
    if y { ret += "-y " }
    if one { ret += "-1 " }
    if comma { ret += "-, " }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    if self.files.count == 0 {
      ret += pwd
    }
    return ret
  }
}
