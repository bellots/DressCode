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
    
    func testView(){
        let view = UIView(
            .backgroundColor(.purple),
            .cornerRadius(5),
            .borderWidth(5),
            .borderColor(.blue)
        )
        
        XCTAssertEqual(view.backgroundColor, .purple)
        XCTAssertEqual(view.layer.cornerRadius, 5)
        XCTAssertEqual(view.layer.borderWidth, 5)
        XCTAssertEqual(view.layer.borderColor, UIColor.blue.cgColor)

        
        view.setProperties(
            .stroke(.red, 2)
        )
        
        XCTAssertEqual(view.layer.borderColor, UIColor.red.cgColor)
        XCTAssertEqual(view.layer.borderWidth, 2)
        
    }
    
    
    func testLabel() {
        let label = UILabel(
            .text("test"),
            .color(.blue),
            .alphaBackgroundColor(.purple),
            .font(UIFont.boldSystemFont(ofSize: 23)),
            .alignment(.right)
        )
        XCTAssertEqual(label.text, "test")
        XCTAssertEqual(label.textColor, .blue)
        XCTAssertEqual(label.backgroundColor, UIColor.purple.withAlphaComponent(0.5))
        XCTAssertEqual(label.font, UIFont.boldSystemFont(ofSize: 23))
        XCTAssertEqual(label.textAlignment, .right)
        
        label.setProperties(
            .attributedText(NSAttributedString(string: "wasd")
            )
        )
        XCTAssertEqual(label.attributedText, NSAttributedString(string: "wasd"))
        
//        UILabel.setStylesGlobally(
//            .color(.purple)
//        )
    }
    
    func testButton() {
        let button = UIButton(
            .color(.brown, for: .disabled),
            .color(.purple),
            .font(UIFont.boldSystemFont(ofSize: 30)),
            .text("disabled", for: .disabled),
            .text("normal"),
            .verticalAlignment(.bottom),
            .horizontalAlignment(.right)
        )
        
        XCTAssertEqual(button.titleColor(for: .disabled), .brown)
        XCTAssertEqual(button.titleColor(for: .normal), .purple)
        XCTAssertEqual(button.titleLabel?.font, UIFont.boldSystemFont(ofSize: 30))
        XCTAssertEqual(button.title(for: .normal), "normal")
        XCTAssertEqual(button.title(for: .disabled), "disabled")
        XCTAssertEqual(button.contentVerticalAlignment, .bottom)
        XCTAssertEqual(button.contentHorizontalAlignment, .right)
        
        button.setProperties(
            .attributedText(NSAttributedString(string: "wasd"), for: .disabled)
        )
        
        XCTAssertEqual(button.attributedTitle(for: .disabled), NSAttributedString(string: "wasd"))
    }
    
    
    func testUITextField() {
        let textField = UITextField(
            .placeholder("placeholder"),
            .borderStyle(.none),
            .text("Text"),
            .color(.brown),
            .font(UIFont.systemFont(ofSize: 32)),
            .alignment(.left),
            .type(.password)
        )
        
        
        XCTAssertEqual(textField.placeholder, "placeholder")
        XCTAssertEqual(textField.borderStyle, .none)
        XCTAssertEqual(textField.text, "Text")
        XCTAssertEqual(textField.textColor, .brown)
        XCTAssertEqual(textField.font, UIFont.systemFont(ofSize: 32))
        XCTAssertEqual(textField.textAlignment, .left)
        XCTAssertEqual(textField.isSecureTextEntry, true)
        XCTAssertEqual(textField.keyboardType, .default)
        
        textField.setProperties(
            .type(.email)
        )
        XCTAssertEqual(textField.isSecureTextEntry, false)
        XCTAssertEqual(textField.keyboardType, .emailAddress)
        
        textField.setProperties(
            .type(.normal)
        )
        XCTAssertEqual(textField.isSecureTextEntry, false)
        XCTAssertEqual(textField.keyboardType, .default)
        
        textField.setProperties(
            .type(.numeric)
        )
        XCTAssertEqual(textField.isSecureTextEntry, false)
        XCTAssertEqual(textField.keyboardType, .numberPad)
        

    }
    
    
    func testUISegmentedControl() {
        let segmentedControl = UISegmentedControl()
        if #available(iOS 13, *) {
            segmentedControl.setProperties(
                .selectedTintColor(.blue)
            )
            XCTAssertEqual(segmentedControl.selectedSegmentTintColor, .blue)
        }
        segmentedControl.setProperties(
            .deselectedTintColor(.yellow)
        )
        XCTAssertEqual(segmentedControl.tintColor, .yellow)
    }
    
    static var allTests = [
        ("testCustomClosure", testCustomClosure),
        ("testCustomValue", testCustomValue),
        ("testView", testView),
        ("testLabel", testLabel),
        ("testButton", testButton),
    ]
}
