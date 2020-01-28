import XCTest
import UIKit
@testable import DressCode

final class DressCodeTests: XCTestCase {
    
    func testCustomValue() {
        let view = UIView(.custom(.blue, keyPath: \.backgroundColor))
        XCTAssertEqual(view.backgroundColor, .blue)
    }
    
    func testEmpty(){
        let _ = UIView(.empty())
        XCTAssertTrue(true)
    }
    
    func testCustomClosure() {
        let view = UIView(.custom { $0.backgroundColor = .blue })
        XCTAssertEqual(view.backgroundColor, .blue)
    }
    
    func testBackgroundColor(){
        let view = UIView(.backgroundColor(.purple))
        XCTAssertEqual(view.backgroundColor, .purple)
    }
    
    func testCornerRadius(){
        let view = UIView(.cornerRadius(5))
        XCTAssertEqual(view.layer.cornerRadius, 5)
    }
    
    func testBorderWidth(){
        let view = UIView(.borderWidth(5))
        XCTAssertEqual(view.layer.borderWidth, 5)
    }
    
    func testTextLabel() {
        let label = UILabel(.text("test"))
        XCTAssertEqual(label.text, "test")
    }
    
    func testColorLabel() {
        let label = UILabel(.color(.blue))
        XCTAssertEqual(label.textColor, .blue)
    }
    
    static var allTests = [
        ("testBorderWidth", testBorderWidth),
        ("testBorderWidth", testBorderWidth),
        ("testCornerRadius", testCornerRadius),
        ("testCustomClosure", testCustomClosure),
        ("testCustomValue", testCustomValue),
        ("testTextLabel", testTextLabel),
        ("testColorLabel", testColorLabel),
        ("testBackgroundColor", testBackgroundColor),
    ]
}
