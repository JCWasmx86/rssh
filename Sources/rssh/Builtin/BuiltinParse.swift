import ArgumentParser

// Builtin commands are only there for pipes
public func parseBuiltin(args: [String], stdin: String) -> String? {
  var newcmd = ""
  do {
    var parsable: ParsableCommand?
    switch args[0] {
    case "sort":
      parsable = try BuiltinSort.parseAsRoot(Array(args[1...]))
    case "cat":
      parsable = try BuiltinCat.parseAsRoot(Array(args[1...]))
    case "grep":
      parsable = try BuiltinGrep.parseAsRoot(Array(args[1...]))
    case "tr":
      parsable = try BuiltinTr.parseAsRoot(Array(args[1...]))
    case "sed":
      parsable = try BuiltinSed.parseAsRoot(Array(args[1...]))
    case "uniq":
      parsable = try BuiltinUniq.parseAsRoot(Array(args[1...]))
    case "wc":
      parsable = try BuiltinWc.parseAsRoot(Array(args[1...]))
    case "tail":
      parsable = try BuiltinTail.parseAsRoot(Array(args[1...]))
    case "head":
      parsable = try BuiltinHead.parseAsRoot(Array(args[1...]))
    default:
      return nil
    }
    if parsable is BuiltinCommand {
      newcmd = try (parsable as! BuiltinCommand).apply(stdin: stdin)
    } else {
      switch args[0] {
      case "sort":
        print(BuiltinSort.helpMessage(includeHidden: true))
      case "cat":
        print(BuiltinCat.helpMessage(includeHidden: true))
      case "grep":
        print(BuiltinGrep.helpMessage(includeHidden: true))
      case "tr":
        print(BuiltinTr.helpMessage(includeHidden: true))
      case "sed":
        print(BuiltinSed.helpMessage(includeHidden: true))
      case "uniq":
        print(BuiltinUniq.helpMessage(includeHidden: true))
      case "wc":
        print(BuiltinWc.helpMessage(includeHidden: true))
      case "tail":
        print(BuiltinTail.helpMessage(includeHidden: true))
      case "head":
        print(BuiltinHead.helpMessage(includeHidden: true))
      default:
        return nil
      }
    }
  } catch {
    switch args[0] {
    case "sort":
      print(BuiltinSort.fullMessage(for: error))
    case "cat":
      print(BuiltinCat.fullMessage(for: error))
    case "grep":
      print(BuiltinGrep.fullMessage(for: error))
    case "tr":
      print(BuiltinTr.fullMessage(for: error))
    case "sed":
      print(BuiltinSed.fullMessage(for: error))
    case "uniq":
      print(BuiltinUniq.fullMessage(for: error))
    case "wc":
      print(BuiltinWc.fullMessage(for: error))
    case "tail":
      print(BuiltinTail.fullMessage(for: error))
    case "head":
      print(BuiltinHead.fullMessage(for: error))
    default:
      return nil
    }
    return nil
  }
  return newcmd
}
