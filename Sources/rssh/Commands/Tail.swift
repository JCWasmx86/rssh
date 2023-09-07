import ArgumentParser

struct Tail: ParsableCommand, SSHCommand {
  static var configuration = CommandConfiguration(
    commandName: "tail",
    abstract: "Display the last part of a file"
  )
  @Flag(
    name: [.customShort("F")],
    help:
      "The -F option implies the -f option, but tail will also check to see if the file being followed has been renamed or rotated. The file is closed and reopened when tail detects that the filename being read from has a new inode number."
  ) var F: Bool = false
  @Flag(
    name: [.customShort("f")],
    help:
      "The -f option causes tail to not stop when end of file is reached, but rather to wait for additional data to be appended to the input.  The -f option is ignored if the standard input is a pipe, but not if it is a FIFO."
  ) var f: Bool = false
  @Option(name: [.customShort("b")], help: "The location is number 512-byte blocks.") var b: Int?
  @Option(name: [.customShort("c")], help: "The location is number bytes.") var c: Int?
  @Option(name: [.customShort("n")], help: "The location is number lines.") var n: Int?
  @Flag(
    name: [.customShort("q")],
    help: "Suppresses printing of headers when multiple files are being examined."
  ) var q: Bool = false
  @Flag(
    name: [.customShort("r")],
    help:
      "The -r option causes the input to be displayed in reverse order, by line. Additionally, this option changes the meaning of the -b -c and -n options.  When the -r option is specified, these options specify the number of bytes, lines or 512-byte blocks to display, instead of the bytes, lines or blocks from the beginning or end of the input from which to begin the display.  The default for the -r option is to display all of the input."
  ) var r: Bool = false
  @Argument(help: "Files") var files: [String]

  public func cmd(pwd: String, home: String) -> String {
    var ret = "tail "
    if F { ret += "-F " }
    if f { ret += "-f " }
    if b != nil { ret += "-b " + String(b!) + " " }
    if c != nil { ret += "-c " + String(c!) + " " }
    if n != nil { ret += "-n " + String(n!) + " " }
    if q { ret += "-q " }
    if r { ret += "-r " }
    for file in self.files { ret += fixup(pwd: pwd, home: home, file: file) }
    return ret
  }
}
