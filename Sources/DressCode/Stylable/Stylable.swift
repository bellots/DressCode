//
//  Stylable.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 27/12/2019.
//  Copyright © 2019 bellots. All rights reserved.
//

import Foundation
import UIKit

public protocol Stylable {
    init()
}

extension UIView: Stylable {}

public extension Stylable where Self:UIView{
    static func setStylesGlobally(_ styles: Property<Self>...){
        styles.forEach({_ in Self.appearance().apply(styles)})
    }
}

public extension Stylable {
    
    init(_ style: Property<Self>...) {
        self.init()
        apply(style)
    }
    
    func setStyle(_ styles: Property<Self>...) {
        styles.forEach({$0.style(self)})
    }
    
    fileprivate func apply(_ styles: [Property<Self>]) {
        styles.forEach({$0.style(self)})
    }
    
}

