import XCTest

@testable import rssh

final class ParseTests: XCTestCase {
  func testParse() throws {
    var (arr, _) = parseCommands(string: "foo bar baz")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 3)
    (arr, _) = parseCommands(string: "foo bar baz|foo bar baz")
    XCTAssertEqual(arr.count, 2)
    XCTAssertEqual(arr[0].count, 3)
    XCTAssertEqual(arr[1].count, 3)
    (arr, _) = parseCommands(string: "foo bar baz|foo bar baz|grep 'foo|'")
    XCTAssertEqual(arr.count, 3)
    XCTAssertEqual(arr[0].count, 3)
    XCTAssertEqual(arr[1].count, 3)
    XCTAssertEqual(arr[2].count, 2)
    (arr, _) = parseCommands(string: "")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 0)
    (arr, _) = parseCommands(string: "# Foo")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 0)
    (arr, _) = parseCommands(string: "foo bar# Foo")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 2)
    XCTAssertEqual(arr[0][1], "bar")
    (arr, _) = parseCommands(string: "foo bar # Foo")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 2)
    XCTAssertEqual(arr[0][1], "bar")
    (arr, _) = parseCommands(string: "foo \'foo\'")
    XCTAssertEqual(arr.count, 1)
    XCTAssertEqual(arr[0].count, 2)
    XCTAssertEqual(arr[0][1], "foo")
  }
}
