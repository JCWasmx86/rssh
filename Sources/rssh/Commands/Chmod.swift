import ArgumentParser

struct Chmod: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "chmod", abstract: "Change file modes")
  @Flag(
    name: [.customShort("f")],
    help:
      "Do not display a diagnostic message if chmod could not modify the mode for file, nor modify the exit status to reflect such failures."
  )
  var f: Bool = false
  @Flag(
    name: [.customShort("H")],
    help:
      "If the -R option is specified, symbolic links on the command line are followed. (Symbolic links encountered in the tree traversal are not followed by default.)"
  )
  var H: Bool = false
  @Flag(
    name: [.customShort("h")],
    help:
      "If the file is a symbolic link, change the mode of the link itself rather than the file that the link points to."
  )
  var h: Bool = false
  @Flag(
    name: [.customShort("L")],
    help: "If the -R option is specified, all symbolic links are followed.")
  var L: Bool = false
  @Flag(
    name: [.customShort("P")],
    help: "If the -R option is specified, no symbolic links are followed. This is the default.")
  var P: Bool = false
  @Flag(
    name: [.customShort("R")],
    help:
      "Change the modes of the file hierarchies rooted in the files instead of just the files themselves."
  )
  var R: Bool = false
  @Flag(
    name: [.customShort("v")],
    help: "Cause chmod to be verbose, showing filenames as the mode is modified.")
  var v: Bool = false
  @Argument(help: "Mode")
  var mode: String
  @Argument(help: "Files")
  var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "chmod "
    if f { ret += "-f " }
    if H { ret += "-H " }
    if h { ret += "-h " }
    if L { ret += "-L " }
    if P { ret += "-P " }
    if R { ret += "-R " }
    if v { ret += "-v " }
    ret += mode
    ret += " "
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
