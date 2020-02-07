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
        .grouped(
            .custom(color, keyPath: \.borderColor),
            .custom(width, keyPath: \.borderWidth)
        )
    }
        
}

//MARK: - UILabel Properties

public extension Property where Element: UILabel {
    
    static func textStyle(_ value:UIFont.TextStyle, forFontName name: String) -> Property<Element> {
        let userFont =  UIFontDescriptor.preferredFontDescriptor(withTextStyle: value)
        let pointSize = userFont.pointSize
        guard let customFont = UIFont(name: name, size: pointSize) else {
            fatalError("""
                Failed to load the "\(name)" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
//        return .grouped(
//            .custom(UIFontMetrics.default.scaledFont(for: customFont), keyPath: \.font),
//            .custom(true, keyPath: \.adjustsFontForContentSizeCategory)
//        )
 
        return .grouped(
            .custom(UIFont.preferredCustomFont(forTextStyle: value, fontName: name), keyPath: \.font),
            .custom(true, keyPath: \.adjustsFontForContentSizeCategory)
        )
//        .custom(UIFontMetrics(forTextStyle: value).scaledFont(for: font), keyPath: \.font)
    }
    
    /// The color of the text
    static func color(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.textColor)
    }
    
    /// The label's background color with 0.5 alpha component
    static func alphaBackgroundColor(_ value: UIColor) -> Property<Element> {
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
        .custom { $0.titleLabel?.setProperties(.font(value)) }
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
    static func placeholder(_ value: String, _ color: UIColor? = nil) -> Property<Element> {
        if let color = color {
                let attributedPlaceholder = NSAttributedString(string: value, attributes:[NSAttributedString.Key.foregroundColor: color])
            return .custom(attributedPlaceholder, keyPath: \.attributedPlaceholder)
        }
        return .custom(value, keyPath: \.placeholder)
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

    /// The font of the text
    static func font(_ value: UIFont) -> Property<Element> {
        .custom(value, keyPath: \.font)
    }
    
    /// The keyboard style associated with the text object
    static func type(_ value: UITextField.KeyboardType) -> Property<Element> {
        switch value{
        case .email:
            return .grouped(
                .custom(.emailAddress, keyPath: \.keyboardType),
                .custom(false, keyPath: \.isSecureTextEntry)
            )
        case .password:
            return .grouped(
                .custom(.default, keyPath: \.keyboardType),
                .custom(true, keyPath: \.isSecureTextEntry)
            )
        case .normal:
            return .grouped(
                .custom(.default, keyPath: \.keyboardType),
                .custom(false, keyPath: \.isSecureTextEntry)
            )
        case .numeric:
            return .grouped(
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
    @available(iOS 13.0, *)
    static func selectedTintColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.selectedSegmentTintColor)
    }

    /// The color to use for the deselected segment.
    static func deselectedTintColor(_ value: UIColor) -> Property<Element> {
        .custom(value, keyPath: \.tintColor)
    }

}
