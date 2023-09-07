protocol SSHCommand {
  func cmd(pwd: String, home: String) -> String
}
