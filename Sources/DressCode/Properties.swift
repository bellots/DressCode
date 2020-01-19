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
    
    static func placeholder(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.placeholder)
    }
    
    static func text(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.text)
    }
    
    static func color(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.textColor)
    }

    static func placeholderColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.placeholderColor)
    }
    
    static func font(_ value: UIFont) -> Property<Element> {
        .custom(value, keyPath: \.font)
    }
 
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
}
