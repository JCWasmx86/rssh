import Foundation

enum Continuation {
  case semicolon
  case pipe
}
func parseCommands(string: String) -> ([[String]], [Continuation]) {
  var tmpbuffer = ""
  var commands: [[String]] = []
  var args: [String] = []
  var inString = false
  var isEscaped = false
  var quoteType: Character?
  var conts: [Continuation] = []
  for character in string {
    if isEscaped {
      if "\\\"'$`*?[]|&;()<>!#%{}".contains(character) {
        tmpbuffer.append(character)
      } else {
        tmpbuffer.append("\\")
        tmpbuffer.append(character)
      }
      isEscaped = false
    } else if inString {
      if character != quoteType {
        if character == "\\" { isEscaped = true } else { tmpbuffer.append(character) }
      } else {
        inString = false
      }
    } else {
      if character == "\\" {
        isEscaped = true
      } else if character == "\'" || character == "\"" {
        quoteType = character
        inString = true
      } else if character == " " {
        if tmpbuffer.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
          args.append(tmpbuffer)
        }
        tmpbuffer = ""
      } else if character == ";" || character == "|" || character == "#" {
        if tmpbuffer.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
          args.append(tmpbuffer)
        }
        tmpbuffer = ""
        commands.append(args)
        args = []
        if character == "#" { return (commands, conts) }
        conts.append(character == ";" ? .semicolon : .pipe)
      } else {
        tmpbuffer.append(character)
      }
    }
  }
  if tmpbuffer.trimmingCharacters(in: .whitespacesAndNewlines) != "" { args.append(tmpbuffer) }
  tmpbuffer = ""
  commands.append(args)
  conts.append(.semicolon)
  return (commands, conts)
}
