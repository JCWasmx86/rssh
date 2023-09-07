import ArgumentParser
import Foundation

struct BuiltinTr: ParsableCommand, BuiltinCommand {
  static var configuration = CommandConfiguration(
    commandName: "tr", abstract: "Translate or delete characters")
  @Flag(
    name: [.customShort("d"), .customLong("delete")],
    help:
      "Delete character"
  )
  var d: Bool = false
  @Option(name: .shortAndLong, help: "Use complement of SET1.")
  var complement: Bool = false
  @Argument(help: "The character set to translate from.")
  var set1: String

  @Argument(help: "The character set to translate to. If not provided, translate to itself.")
  var set2: String?

  public func apply(stdin: String) throws -> String {
    let set1 = self.set1.unicodeScalars
    let set2: String.UnicodeScalarView
    if let s = self.set2 {
      set2 = s.unicodeScalars
    } else {
      set2 = set1
    }
    var res = ""
    for scalar in stdin.unicodeScalars {
      if self.d {
        if !set1.contains(scalar) {
          res.unicodeScalars.append(scalar)
        }
      } else {
        let index = set1.firstIndex(of: scalar)
        if self.complement {
          if index != nil {
            res.unicodeScalars.append(set2[index!])
          }
        } else {
          res.unicodeScalars.append(index.map { set2[$0] } ?? scalar)
        }
      }
    }
    return res
  }
}
