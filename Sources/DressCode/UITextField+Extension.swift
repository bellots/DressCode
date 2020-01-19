//
//  UITextField+Extension.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

public extension UITextField{
    @IBInspectable public var placeholderColor: UIColor? {
        get {
            return self.placeholderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    enum KeyboardType{
        case normal
        case email
        case password
        case numeric
    }    
}
