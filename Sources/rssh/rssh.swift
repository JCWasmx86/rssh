import ArgumentParser
import CoreFoundation
import Foundation

@main
struct RSSH: ParsableCommand {
  static var configuration = CommandConfiguration(
    commandName: "rssh", abstract: "Simulate shell on remote system while keeping state client-side"
  )

  @Option(help: "The path to the rc file")
  var rcfile: String = "\(NSHomeDirectory())/.rsshrc"
  @Option(help: "The path to the history file")
  var historyfile: String = "\(NSHomeDirectory())/.rsshhist"

  func run() throws {
    let state = State(
      histfile: NSString(string: self.historyfile).expandingTildeInPath,
      rcfile: NSString(string: self.rcfile).expandingTildeInPath)
    do {
      try state.connect()
      while true {
        try state.doCommand()
      }
    } catch {
      print(error)
    }
  }
}
