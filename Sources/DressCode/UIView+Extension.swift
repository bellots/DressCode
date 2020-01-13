//
//  UIView+Extension.swift
//  
//
//  Created by Andrea Bellotto on 13/01/2020.
//

import UIKit

extension UIView{
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable  public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            if let layerColor = layer.borderColor {
                return UIColor(cgColor: layerColor)
            } else {
                return UIColor(white: 0, alpha: 0);
            }
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
}
