import PathKit

public func fixup(pwd: String, home: String, file: String) -> String {
  var realfile = file
  if file.hasPrefix("~") {
    realfile = home + "/" + file.substring(from: 1)
  }
  let pfile = Path(realfile)
  if pfile.isAbsolute {
    return pfile.normalize().description
  }
  return Path(pwd + "/" + file)
    .normalize().description
}
