import CoreFoundation
import Foundation
import PathKit
import Shout
import rl

func rlEmpty(a: Int32, b: Int32) -> Int32 {
  return 0
}

func signalHandler(signum: Int32) {
  print()
  rl_delete_text(Int32(0), Int32(rl_end))
  rl_clear_visible_line()
  rl_reset_line_state()
  rl_replace_line("", 0)
  rl_on_new_line()
  rl_redisplay()
}

class State {
  var pwd: String
  var histfile: String
  var rcfile: String
  var server: String
  var user: String
  var key: String
  var origpwd: String
  var ssh: SSH?
  var success: Bool

  public init(histfile: String, rcfile: String) {
    self.histfile = histfile
    self.rcfile = rcfile
    self.pwd = ""
    self.server = ""
    self.user = ""
    self.key = ""
    self.success = true
    self.ssh = nil
    self.origpwd = ""
    self.parseRcFile()
    read_history(self.histfile)
    rl_bind_key(9 /* \t */, rlEmpty)
    signal(SIGINT, signalHandler)
  }

  public func connect() throws {
    self.ssh = try SSH(host: server)
    try ssh!.authenticate(username: self.user, privateKey: self.key)
    let (_, s) = try ssh!.capture("pwd")
    self.pwd = s.trimmingCharacters(in: .whitespacesAndNewlines)
    self.origpwd = self.pwd
  }

  func handleNano(args: [String]) throws {
    if args.count != 2 {
      print("Usage: nano <file>")
      self.success = false
      return
    }
    let sftp = try self.ssh!.openSftp()
    let path = fixup(pwd: self.pwd, home: self.origpwd, file: args[1])
    let parent = Path(path).parent()
    _ = try self.ssh!.capture("mkdir " + parent.description)
    let (retcode, _) = try self.ssh!.capture("stat " + path)
    let exists = retcode == 0
    let fileManager = FileManager.default
    let cacheDir = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    let fileName = UUID().uuidString
    let fileURL = cacheDir!.appendingPathComponent(fileName)
    if exists {
      try sftp.download(remotePath: path, localURL: fileURL)
    } else {
      fileManager.createFile(atPath: fileURL.path, contents: nil)
    }
    // Not the nicest solution, but I can't get Process() to work
    system("nano " + fileURL.path)
    let d = fileManager.contents(atPath: fileURL.path)
    if exists {
      try sftp.removeFile(path)
    }
    try sftp.upload(data: d!, remotePath: path)
    self.success = true
  }

  func handleCd(args: [String]) throws {
    if args.count == 2 {
      let p = fixup(pwd: self.pwd, home: self.origpwd, file: args[1])
      var code = try ssh!.execute("test -d " + p)
      if code == 0 {
        self.pwd = p
        success = true
      } else {
        code = try ssh!.execute("test -e " + p)
        if code == 0 {
          print("cd: " + p + ": Not a directory")
        } else {
          print("cd: " + p + ": No such file or directory")
        }
        success = false
      }
    } else {
      pwd = origpwd
      success = true
    }
  }

  func printHistory(args: [String]) -> String? {
    if args.count != 1 {
      print("Usage: history")
      self.success = false
      return nil
    }
    self.success = true
    if let text = try? NSString(
      contentsOfFile: self.histfile as String, encoding: String.Encoding.utf8.rawValue)
    {
      let lines = text.components(separatedBy: CharacterSet.newlines)
      let len = String(lines.count + 1).count + 1
      var str = ""
      var idx = 0
      for line in lines {
        var l1 = String(idx + 1).count
        while l1 != len {
          str.append(" ")
          l1 += 1
        }
        str.append(String(idx + 1))
        str.append("  ")
        str.append(line)
        str.append("\n")
        if idx == lines.count - 2 {
          break
        }
        idx += 1
      }
      return str
    }
    return ""
  }

  func handleCommand(args: [String], pipe: String?, capture: Bool) throws -> String? {
    if args.isEmpty {
      return nil
    }
    if args[0] == "cd" {
      try self.handleCd(args: args)
      return nil
    } else if args[0] == "clear" {
      print("\u{001B}[1;1H\u{001B}[2J\u{001B}c", terminator: "")
      success = true
      return nil
    } else if args[0] == "nano" {
      try handleNano(args: args)
      return nil
    } else if args[0] == "exit" {
      exit(self.success ? 1 : 0)
    } else if args[0] == "history" {
      return printHistory(args: args)
    } else if pipe != nil {
      let ret = parseBuiltin(args: args, stdin: pipe!)
      self.success = ret != nil
      return ret
    }
    var found = false
    let newcmd = parse(args: args, home: self.origpwd, pwd: pwd, found: &found)
    if !found {
      print("\u{001B}[0;31m" + args[0] + ": command not found\u{001B}[0m")
      success = false
      return nil
    }
    if let ncmd = newcmd {
      if ncmd != "" {
        print("\u{001B}[0;36m[+] " + ncmd + "\u{001B}[0m")
        if capture {
          let (retcode, output) = try ssh!.capture(ncmd)
          success = retcode == 0
          return output
        } else {
          let retcode = try ssh!.execute(ncmd)
          success = retcode == 0
          return ""
        }
      } else {
        success = false
      }
    } else {
      success = false
    }
    return nil
  }

  public func doCommand() throws {
    let prompt = self.prompt()
    let cmdopt = readline(prompt)
    var last = rssh_previous_history()
    defer {
      free(last)
    }
    if let cmd = cmdopt {
      if String(cString: cmd).trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return
      }
      let lstr = last == nil ? nil : String(cString: last!)
      let cstr = String(cString: cmd)
      if last == nil || (last != nil && lstr != cstr) {
        add_history(cmd)
        write_history(histfile)
      }
      let (argvs, conts) = parseCommands(string: cstr)
      if argvs.count == 0 || conts.count == 0 {
        return
      }
      if last != nil {
        free(last)
      }
      last = cmdopt
      var previousOutput: String?
      self.success = true
      var dead = false
      for idx in 0...argvs.count - 1 {
        let cont = conts[idx]
        if dead && cont == .semicolon {
          dead = false
          print("Skipping", cont, argvs[idx])
          if idx != argvs.count - 1 {
            self.success = true
          }
          previousOutput = nil
          continue
        }
        print("\u{001B}[0;34m[*]", cont, argvs[idx], "\u{001B}[0m")
        let output = try self.handleCommand(
          args: argvs[idx], pipe: previousOutput, capture: cont == .pipe)
        if !self.success {
          if output != nil {
            print(output!, terminator: "")
            if !output!.hasSuffix("\n") && !output!.isEmpty {
              print()
            }
            previousOutput = nil
          }
          dead = true
          continue
        }
        if output != nil {
          if cont == .semicolon {
            print(output!, terminator: "")
            if !output!.hasSuffix("\n") && !output!.isEmpty {
              print()
            }
            previousOutput = nil
          } else {
            previousOutput = output
          }
        }
      }
    } else {
      exit(0)
    }
  }

  func prompt() -> String {
    return "\u{001B}[0;32m(" + self.user + "@" + self.server + ")\u{001B}[0m:" + "\u{001B}[0;31m"
      + self.pwd + "\u{001B}[0m" + (success ? "🟢" : "🔴") + "$ "
  }

  func parseRcFile() {
    if let text = try? NSString(
      contentsOfFile: self.rcfile as String, encoding: String.Encoding.utf8.rawValue)
    {
      let lines = text.components(separatedBy: CharacterSet.newlines)
      for line in lines {
        if line.hasPrefix("#") || line.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
          continue
        }
        let (parts, _) = parseCommands(string: line.trimmingCharacters(in: .whitespacesAndNewlines))
        if parts.isEmpty || parts[0].isEmpty
          || parts[0][0].trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
          continue
        }
        if parts.count > 1 {
          print(".rc file does not support continuing a command with pipes or semicolons")
          continue
        }
        let args = parts[0]
        switch args[0] {
        case "connect":
          if args.count != 3 {
            print("Usage: connect <server> <user> <key>")
            exit(1)
          }
          self.server = args[1].split(separator: "@")[1].description
          self.user = args[1].split(separator: "@")[0].description
          self.key = NSString(string: args[2]).expandingTildeInPath
        default:
          print("Unknown command:", args[0])
        }
      }
    }
  }
}
