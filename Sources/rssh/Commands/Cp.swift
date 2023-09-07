import ArgumentParser

struct Cp: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "cp", abstract: "Copy files")
  @Flag(
    name: [.customShort("H")],
    help:
      "If the -R option is specified, symbolic links on the command line are followed. (Symbolic links encountered in the tree traversal are not followed.)"
  )
  var H: Bool = false
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
      "If source_file designates a directory, cp copies the directory and the entire subtree connected at that point."
  )
  var R: Bool = false
  @Flag(
    name: [.customShort("a")],
    help: "Archive mode.  Same as -RpP.")
  var a: Bool = false
  @Flag(
    name: [.customShort("f")],
    help:
      "For each existing destination pathname, remove it and create a new file, without prompting for confirmation regardless of its permissions. (The -f option overrides any previous -i or -n options.)"
  )
  var f: Bool = false
  // -i is not applicable here
  @Flag(
    name: [.customShort("l")],
    help: "Create hard links to regular files in a hierarchy instead of copying.")
  var l: Bool = false
  @Flag(
    name: [.customShort("n")],
    help:
      "Do not overwrite an existing file. (The -n option overrides any previous -f or -i options.)")
  var n: Bool = false
  @Flag(
    name: [.customShort("p")],
    help:
      "Cause cp to preserve the following attributes of each source file in the copy: modification time, access time, file flags, file mode, ACL, user ID, and group ID, as allowed by permissions."
  )
  var p: Bool = false
  @Flag(
    name: [.customShort("v")],
    help: "Cause cp to be verbose, showing files as they are copied.")
  var v: Bool = false
  @Flag(
    name: [.customShort("x")],
    help: "File system mount points are not traversed.")
  var x: Bool = false
  @Argument(help: "Files")
  var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "cp "
    if H {
      ret += "-H "
    }
    if L {
      ret += "-L "
    }
    if P {
      ret += "-P "
    }
    if R {
      ret += "-R "
    }
    if a {
      ret += "-a "
    }
    if f {
      ret += "-f "
    }
    if l {
      ret += "-l "
    }
    if n {
      ret += "-n "
    }
    if p {
      ret += "-p "
    }
    if v {
      ret += "-v "
    }
    if x {
      ret += "-x "
    }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
