import ArgumentParser

struct Cat: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "cat", abstract: "Concatenate files and print on the standard output")
  @Flag(name: [.customShort("b")], help: "Number the non-blank output lines, starting at 1.")
  var b: Bool = false
  @Flag(
    name: [.customShort("e")],
    help:
      "Display non-printing characters (see the -v option), and display a dollar sign ('$') at the end of each line."
  )
  var e: Bool = false
  @Flag(
    name: [.customShort("l")],
    help:
      "Set an exclusive advisory lock on the standard output file descriptor.  This lock is set using fcntl(2) with the F_SETLKW command. If the output file is already locked, cat will block until the lock is acquired."
  )
  var l: Bool = false
  @Flag(name: [.customShort("n")], help: "Number the output lines, starting at 1.")
  var n: Bool = false
  @Flag(
    name: [.customShort("s")],
    help: "Squeeze multiple adjacent empty lines, causing the output to be single spaced.")
  var s: Bool = false
  @Flag(
    name: [.customShort("t")],
    help: "Display non-printing characters (see the -v option), and display tab characters as '^I'."
  )
  var t: Bool = false
  @Flag(name: [.customShort("u")], help: "Disable output buffering.")
  var u: Bool = false
  @Flag(
    name: [.customShort("v")],
    help:
      "Display non-printing characters so they are visible.  Control characters print as '^X' for control-X; the delete character (octal 0177) prints as '^?'. Non-ASCII characters (with the high bit set) are printed as 'M-' (for meta) followed by the character for the low 7 bits."
  )
  var v: Bool = false
  @Argument(help: "Files")
  var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "cat "
    var s = "-"
    if b {
      s += "b"
    }
    if e {
      s += "e"
    }
    if l {
      s += "l"
    }
    if n {
      s += "n"
    }
    if self.s {
      s += "s"
    }
    if t {
      s += "t"
    }
    if u {
      s += "u"
    }
    if v {
      s += "v"
    }
    if s.count != 1 {
      ret += s
      ret += " "
    }
    for file in self.files {
      ret += fixup(pwd: pwd, home: home, file: file)
      ret += " "
    }
    return ret
  }
}
