//
//  UITextField+Extension.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

/// Function utils for UITextField
public extension UITextField{
//    @IBInspectable var placeholderColor: UIColor? {
//        get {
//            return self.placeholderColor
//        }
//        set {
//            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
//        }
//    }
    
    enum KeyboardType{
        case normal
        case email
        case password
        case numeric
    }    
}
