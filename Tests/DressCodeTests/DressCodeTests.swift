import XCTest
@testable import DressCode

final class DressCodeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(DressCode().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}