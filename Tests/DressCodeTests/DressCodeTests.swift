import XCTest
import UIKit
@testable import DressCode

enum Theme: Themeable {
    case light
    case dark

}
enum TestStyle<View>:String, CaseIterable, StylableView {
    case test1
    case test2
}

extension Property where Element:UILabel {
    static func style(for styleView:TestStyle<Element>, forTheme theme:Themeable) -> Property<Element>{
        return styleView.style(for: theme)
    }
}

extension TestStyle where View: UILabel {
    func style(for theme: Themeable) -> Property<View> {
        switch self {
        case .test1:
            return .grouped(
                .text("test1"),
                .color(.blue)
            )
        case .test2:
            return .grouped(
                .style(for: .test1, forTheme: theme),
                .text("test2")
            )
        }
    }
}

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
        
        UILabel.setStylesGlobally(
            .color(.purple)
        )
        
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
    
    func testStyle() {
        let view = UIView(
            TestStyle.test1.style(for: Theme.light)
        )
        
        let label = UILabel(
            .style(for: .test1, forTheme: Theme.light)
        )
        XCTAssertEqual(label.text, "test1")
        
        label.setProperties(.style(for: .test2, forTheme: Theme.light))
        XCTAssertEqual(label.text, "test2")
    }

    
    func testThemeFactory() {
        
        let themeFactory = ThemeFactory(theme: Theme.light)
        themeFactory.current = .dark
    
        class ViewController:UIViewController, ViewControllerThemeable {
            
            func setupStyles(for theme: Themeable) {
                let label = UILabel()
                label.setProperties(.alignment(.right))
            }
        }
    
        let viewController = ViewController()
        themeFactory.registerUpdates(for: viewController)
        
        themeFactory.setupStyles()
        
        let themeFactory2 = ThemeFactory(theme: Theme.light, viewControllerToUpdate: viewController)
        themeFactory2.current = .dark
        
        XCTAssert(themeFactory.viewControllerToUpdate.map({$0.isEmpty}).filter({$0}).isEmpty)
        
        let window = UIWindow()
        window.rootViewController = viewController
        
        themeFactory.refresh(window: window)
    }
    
    
    static var allTests = [
        ("testCustomClosure", testCustomClosure),
        ("testCustomValue", testCustomValue),
        ("testView", testView),
        ("testLabel", testLabel),
        ("testButton", testButton),
    ]
}
