import ArgumentParser

// dd, test, tree, pwd, passwd, gfind, split, fetch are missing

public func parse(args: [String], home: String, pwd: String, found: inout Bool) -> String? {
  var newcmd = ""
  do {
    var parsable: ParsableCommand?
    found = true
    switch args[0] {
    case "quota": parsable = try Quota.parseAsRoot(Array(args[1...]))
    case "cat": parsable = try Cat.parseAsRoot(Array(args[1...]))
    case "echo": parsable = try Echo.parseAsRoot(Array(args[1...]))
    case "tail": parsable = try Tail.parseAsRoot(Array(args[1...]))
    case "cp": parsable = try Cp.parseAsRoot(Array(args[1...]))
    case "ls": parsable = try Ls.parseAsRoot(Array(args[1...]))
    case "ll":
      var l = (try Ls.parseAsRoot(Array(args[1...])) as! Ls)
      l.l = true
      parsable = l
    case "mkdir": parsable = try Mkdir.parseAsRoot(Array(args[1...]))
    case "chmod": parsable = try Chmod.parseAsRoot(Array(args[1...]))
    case "ln": parsable = try Ln.parseAsRoot(Array(args[1...]))
    case "mv": parsable = try Mv.parseAsRoot(Array(args[1...]))
    case "rm": parsable = try Rm.parseAsRoot(Array(args[1...]))
    case "rmdir": parsable = try Rmdir.parseAsRoot(Array(args[1...]))
    case "touch": parsable = try Touch.parseAsRoot(Array(args[1...]))
    case "chgrp": parsable = try Chgrp.parseAsRoot(Array(args[1...]))
    case "groups": parsable = try Groups.parseAsRoot(Array(args[1...]))
    case "id": parsable = try Id.parseAsRoot(Array(args[1...]))
    case "find": parsable = try Find.parseAsRoot(Array(args[1...]))
    case "df": parsable = try Df.parseAsRoot(Array(args[1...]))
    case "du": parsable = try Du.parseAsRoot(Array(args[1...]))
    case "md5": parsable = try Md5.parseAsRoot(Array(args[1...]))
    case "sha1": parsable = try Sha1.parseAsRoot(Array(args[1...]))
    case "sha224": parsable = try Sha224.parseAsRoot(Array(args[1...]))
    case "sha256": parsable = try Sha256.parseAsRoot(Array(args[1...]))
    case "sha384": parsable = try Sha384.parseAsRoot(Array(args[1...]))
    case "sha512": parsable = try Sha512.parseAsRoot(Array(args[1...]))
    case "sha512t256": parsable = try Sha512t256.parseAsRoot(Array(args[1...]))
    case "rmd160": parsable = try Rmd160.parseAsRoot(Array(args[1...]))
    case "skein256": parsable = try Skein256.parseAsRoot(Array(args[1...]))
    case "skein512": parsable = try Skein512.parseAsRoot(Array(args[1...]))
    case "skein1024": parsable = try Skein1024.parseAsRoot(Array(args[1...]))
    case "date": return args.joined(separator: " ")
    default:
      found = false
      return nil
    }
    if parsable is SSHCommand {
      newcmd = (parsable as! SSHCommand).cmd(pwd: pwd, home: home)
    } else {
      switch args[0] {
      case "quota": print(Quota.helpMessage(includeHidden: true))
      case "cat": print(Cat.helpMessage(includeHidden: true))
      case "echo": print(Echo.helpMessage(includeHidden: true))
      case "tail": print(Tail.helpMessage(includeHidden: true))
      case "cp": print(Cp.helpMessage(includeHidden: true))
      case "ls", "ll": print(Ls.helpMessage(includeHidden: true))
      case "mkdir": print(Mkdir.helpMessage(includeHidden: true))
      case "chmod": print(Chmod.helpMessage(includeHidden: true))
      case "ln": print(Ln.helpMessage(includeHidden: true))
      case "mv": print(Mv.helpMessage(includeHidden: true))
      case "rm": print(Rm.helpMessage(includeHidden: true))
      case "rmdir": print(Rmdir.helpMessage(includeHidden: true))
      case "touch": print(Touch.helpMessage(includeHidden: true))
      case "chgrp": print(Chgrp.helpMessage(includeHidden: true))
      case "groups": print(Groups.helpMessage(includeHidden: true))
      case "id": print(Id.helpMessage(includeHidden: true))
      case "find": print(Find.helpMessage(includeHidden: true))
      case "df": print(Df.helpMessage(includeHidden: true))
      case "du": print(Du.helpMessage(includeHidden: true))
      case "md5": print(Md5.helpMessage(includeHidden: true))
      case "sha1": print(Sha1.helpMessage(includeHidden: true))
      case "sha224": print(Sha224.helpMessage(includeHidden: true))
      case "sha256": print(Sha256.helpMessage(includeHidden: true))
      case "sha384": print(Sha384.helpMessage(includeHidden: true))
      case "sha512": print(Sha512.helpMessage(includeHidden: true))
      case "sha512t256": print(Sha512t256.helpMessage(includeHidden: true))
      case "rmd160": print(Rmd160.helpMessage(includeHidden: true))
      case "skein256": print(Skein256.helpMessage(includeHidden: true))
      case "skein512": print(Skein512.helpMessage(includeHidden: true))
      case "skein1024": print(Skein1024.helpMessage(includeHidden: true))
      default: print(parsable!)
      }
    }
  } catch {
    switch args[0] {
    case "quota": print(Quota.fullMessage(for: error))
    case "cat": print(Cat.fullMessage(for: error))
    case "echo": print(Echo.fullMessage(for: error))
    case "tail": print(Tail.fullMessage(for: error))
    case "cp": print(Cp.fullMessage(for: error))
    case "ls", "ll": print(Ls.fullMessage(for: error))
    case "Mkdir": print(Mkdir.fullMessage(for: error))
    case "chmod": print(Chmod.fullMessage(for: error))
    case "ln": print(Ln.fullMessage(for: error))
    case "mv": print(Mv.fullMessage(for: error))
    case "rm": print(Rm.fullMessage(for: error))
    case "rmdir": print(Rmdir.fullMessage(for: error))
    case "touch": print(Touch.fullMessage(for: error))
    case "chgrp": print(Chgrp.fullMessage(for: error))
    case "groups": print(Groups.fullMessage(for: error))
    case "id": print(Id.fullMessage(for: error))
    case "find": print(Find.fullMessage(for: error))
    case "df": print(Df.fullMessage(for: error))
    case "du": print(Du.fullMessage(for: error))
    case "md5": print(Md5.fullMessage(for: error))
    case "sha1": print(Sha1.fullMessage(for: error))
    case "sha224": print(Sha224.fullMessage(for: error))
    case "sha256": print(Sha256.fullMessage(for: error))
    case "sha384": print(Sha384.fullMessage(for: error))
    case "sha512": print(Sha512.fullMessage(for: error))
    case "sha512t256": print(Sha512t256.fullMessage(for: error))
    case "rmd160": print(Rmd160.fullMessage(for: error))
    case "skein256": print(Skein256.fullMessage(for: error))
    case "skein512": print(Skein512.fullMessage(for: error))
    case "skein1024": print(Skein1024.fullMessage(for: error))
    default: print(error)
    }
    return nil
  }
  return newcmd
}
