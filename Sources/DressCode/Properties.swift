//
//  Properties.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 31/12/2019.
//  Copyright © 2019 bellots. All rights reserved.
//

import UIKit

public extension Property where Element: AnyObject {
    
    
    /// Generic static func to set value for the desired keypath
    static func custom<Value>(_ value: Value, keyPath: ReferenceWritableKeyPath<Element, Value>)  -> Property<Element> {
        return Property<Element> {
            $0[keyPath: keyPath] = value
        }
    }
    
    /// Generic closure to setup your custom properties
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


//MARK: - UIView Properties

public extension Property where Element: UIView {
    
    /// The view's background color
    static func backgroundColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.backgroundColor)
    }

    
    /// The radius to use when drawing rounded corners for the layer's background. Animatable.
    static func cornerRadius(_ value: CGFloat) -> Property<Element> {
        .custom(value, keyPath: \.cornerRadius)
    }

    
    /// The witdh of the layer's border. Animatable.
    static func borderWidth(_ value: CGFloat) -> Property<Element> {
        .custom(value, keyPath: \.borderWidth)
    }

    
    /// The color of the layer's border. Animatable.
    static func borderColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.borderColor)
    }

    /// The color and the width of the layer's border. Animatable
    /// - Parameters:
    ///   - color: the color of the layer's border
    ///   - width: the width of the layer's border
    static func stroke(_ color:UIColor, _ width:CGFloat) -> Property<Element> {
        Property.custom(color, keyPath: \.borderColor)
            .combine(.custom(width, keyPath: \.borderWidth))
    }
        
}

//MARK: - UILabel Properties

public extension Property where Element: UILabel {
    
    /// The color of the text
    static func color(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.textColor)
    }
    
    /// The label's background color with 0.5 alpha component
    static func backgroundColor(_ value: UIColor) -> Property<Element> {
        .custom(value.withAlphaComponent(0.5), keyPath: \.backgroundColor)
    }

    /// The font of the text
    static func font(_ value: UIFont) -> Property<Element> {
        .custom(value, keyPath: \.font)
    }
    
    /// The text displayed by the label
    static func text(_ value: String) -> Property<Element> {
        .custom(value, keyPath: \.text)
    }
    
    /// The current styled text that is displayed by the label
    static func attributedText(_ value: NSAttributedString) -> Property<Element> {
        .custom(value, keyPath: \.attributedText)
    }

    /// The technique to use for aligning the text.
    static func alignment(_ value: NSTextAlignment) -> Property<Element> {
        .custom(value, keyPath: \.textAlignment)
    }
    
}

//MARK: - UIButton Properties

public extension Property where Element: UIButton {
    
    /// The color of the title to use for the specified state. (default .normal)
    static func color(_ value: UIColor, for state: UIButton.State = .normal) -> Property<Element> {
        .custom { $0.setTitleColor(value, for: state) }
    }

    /// The font of the title
    static func font(_ value: UIFont) -> Property<Element> {
        .custom { $0.titleLabel?.setStyle(.font(value)) }
    }
    
    /// The text of the title to use for the specified state. (default .normal)
    static func text(_ value: String, for state: UIButton.State = .normal) -> Property<Element> {
        .custom { $0.setTitle(value, for: state) }
    }
    
    /// The current styled text that is displayed by the title for the specified state. (default .normal)
    static func attributedText(_ value: NSAttributedString, for state: UIButton.State = .normal) -> Property<Element> {
        .custom { $0.setAttributedTitle(value, for: state) }
    }
    
    /// The technique to align the title vertically.
    static func verticalAlignment(_ value: UIControl.ContentVerticalAlignment) -> Property<Element> {
        .custom { $0.contentVerticalAlignment = value }
    }

    /// The technique to align the title horizontally.
    static func horizontalAlignment(_ value: UIControl.ContentHorizontalAlignment) -> Property<Element> {
        .custom { $0.contentHorizontalAlignment = value }
    }
    
}

//MARK: - UITextField Properties

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

//MARK: - UISegmentedControl Properties

public extension Property where Element: UISegmentedControl {
    
    /// The color to use for highlighting the currently selected segment.
    static func selectedTintColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.selectedSegmentTintColor)
    }

    /// The color to use for the deselected segment.
    static func deselectedTintColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.tintColor)
    }

}
