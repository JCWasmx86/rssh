import ArgumentParser

struct Chgrp: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "chgrp", abstract: "Change group")
  @Flag(name: [.customShort("H")])
  var H: Bool = false
  @Flag(name: [.customShort("L")])
  var L: Bool = false
  @Flag(name: [.customShort("P")])
  var P: Bool = false
  @Flag(name: [.customShort("R")])
  var R: Bool = false
  @Flag(name: [.customShort("f")])
  var f: Bool = false
  @Flag(name: [.customShort("h")])
  var h: Bool = false
  @Flag(name: [.customShort("v")])
  var v: Bool = false
  @Flag(name: [.customShort("x")])
  var x: Bool = false
  @Argument(help: "Group")
  var group: String
  @Argument(help: "Files")
  var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "chgrp "
    if H { ret += "-H " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if R { ret += "-R " }
    if f { ret += "-f " }
    if h { ret += "-h " }
    if v { ret += "-v " }
    if x { ret += "-x " }
    ret += group
    ret += " "
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
