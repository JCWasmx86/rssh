import XCTest

@testable import rssh

final class FixupTests: XCTestCase {
  func testFixup() throws {
    var fixed = fixup(pwd: "/", home: "/home/foo", file: "a.txt")
    XCTAssertEqual(fixed, "/a.txt")
    fixed = fixup(pwd: "/", home: "/home/foo", file: "a.txt")
    XCTAssertEqual(fixed, "/a.txt")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "/b.txt")
    XCTAssertEqual(fixed, "/b.txt")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "../opt/a.txt")
    XCTAssertEqual(fixed, "/opt/a.txt")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "~/opt/a.txt")
    XCTAssertEqual(fixed, "/home/foo/opt/a.txt")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "~")
    XCTAssertEqual(fixed, "/home/foo")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "~")
    XCTAssertEqual(fixed, "/home/foo")
    fixed = fixup(pwd: "/usr", home: "/home/foo", file: "./././bin/ls")
    XCTAssertEqual(fixed, "/usr/bin/ls")
  }
}
