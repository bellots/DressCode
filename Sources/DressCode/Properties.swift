//
//  Properties.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 31/12/2019.
//  Copyright © 2019 bellots. All rights reserved.
//

import UIKit

public extension Property where Element: AnyObject {
    static func custom<Value>(_ value: Value, keyPath: ReferenceWritableKeyPath<Element, Value>)  -> Property<Element> {
        return Property<Element> {
            $0[keyPath: keyPath] = value
        }
    }
    static func custom(closure: @escaping (Element) -> () )  -> Property<Element> {
        return Property<Element> { element in
            closure(element)
        }
    }
}

public extension Property {
    static func empty() -> Property<Element>{
        return Property<Element> {_ in }
    }
}

public extension Property where Element: UIView {
    static func backgroundColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.backgroundColor)
    }
    static func cornerRadius(_ value: CGFloat) -> Property<Element> {
        .custom(value, keyPath: \.cornerRadius)
    }
    static func borderWidth(_ value: CGFloat) -> Property<Element> {
        .custom(value, keyPath: \.borderWidth)
    }
    static func borderColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.borderColor)
    }
    static func stroke(_ color:UIColor, _ width:CGFloat) -> Property<Element> {
        Property.custom(color, keyPath: \.borderColor)
            .combine(.custom(width, keyPath: \.borderWidth))
    }
    static func rounded(_ radius:CGFloat) -> Property<Element> {
        return cornerRadius(radius)
    }
}

public extension Property where Element: UILabel {
    static func color(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.textColor)
    }
    static func backgroundColor(_ value: UIColor) -> Property<Element> {
        .custom(value.withAlphaComponent(0.5), keyPath: \.backgroundColor)
    }
    static func font(_ value: UIFont) -> Property<Element> {
        .custom(value, keyPath: \.font)
    }
    static func text(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.text)
    }
    static func attributedText(_ value: NSAttributedString) -> Property<Element> {
        .custom(value, keyPath: \.attributedText)
    }
    static func alignment(_ value: NSTextAlignment) -> Property<Element> {
        .custom(value, keyPath: \.textAlignment)
    }
}

public extension Property where Element: UIButton {

    static func color(_ value: UIColor, for state: UIButton.State = .normal) -> Property<Element> {
        .custom { $0.setTitleColor(value, for: state) }
    }

    static func backgroundColor(_ value: UIColor) -> Property<Element>{
        .custom(value, keyPath: \.backgroundColor)
    }

    static func font(_ value: UIFont) -> Property<Element> {
        .custom { $0.titleLabel?.setStyle(.font(value)) }
    }

    static func text(_ value: String, for state: UIButton.State = .normal) -> Property<Element> {
        .custom { $0.setTitle(value, for: state) }
    }
    static func attributedText(_ value: NSAttributedString, for state: UIButton.State = .normal) -> Property<Element> {

        .custom { $0.setAttributedTitle(value, for: state) }
    }
}

public extension Property where Element: UITextField {
    
    
    /// The string that is displayed when there is no other text in the text field
    static func placeholder(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.placeholder)
    }
    
    
    /// The border style used by the text field
    static func borderStyle(_ value: UITextField.BorderStyle) -> Property<Element> {
        .custom(value, keyPath: \.borderStyle)
    }
    
    
    ///The text displayed by the text field
    static func text(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.text)
    }
    
    
    /// The color of the text
    static func color(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.textColor)
    }

    
    /// The color of the placeholder
    static func placeholderColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.placeholderColor)
    }
    
    
    /// The font of the text
    static func font(_ value: UIFont) -> Property<Element> {
        .custom(value, keyPath: \.font)
    }
 
    
    /// The keyboard style associated with the text object
    static func type(_ value: UITextField.KeyboardType) -> Property<Element> {
        switch value{
        case .email:
            return .combined(
                .custom(.emailAddress, keyPath: \.keyboardType),
                .custom(false, keyPath: \.isSecureTextEntry)
            )
        case .password:
            return .combined(
                .custom(.default, keyPath: \.keyboardType),
                .custom(true, keyPath: \.isSecureTextEntry)
            )
        case .normal:
            return .combined(
                .custom(.default, keyPath: \.keyboardType),
                .custom(false, keyPath: \.isSecureTextEntry)
            )
        case .numeric:
            return .combined(
                .custom(.numberPad, keyPath: \.keyboardType),
                .custom(false, keyPath: \.isSecureTextEntry)
            )
        }
    }

    
    /// The technique to use for aligning the text.
    static func alignment(_ value: NSTextAlignment) -> Property<Element> {
        .custom(value, keyPath: \.textAlignment)
    }
}


public extension Property where Element: UISegmentedControl {
    static func selectedColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.selectedSegmentTintColor)
    }
    static func deselectedColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.tintColor)
    }
}
