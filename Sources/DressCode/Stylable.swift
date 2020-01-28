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

    /// Apply styles directly to the class through UIAppearance
    static func setStylesGlobally(_ properties: Property<Self>...){
        properties.forEach({_ in Self.appearance().apply(properties)})
    }
}

public extension Stylable {
    
    
    /// View's init with custom properties
    init(_ properties: Property<Self>...) {
        self.init()
        apply(properties)
    }
        
    
    /// Add properties to view in a second time
    func setProperties(_ properties: Property<Self>...) {
        properties.forEach({$0.style(self)})
    }
    
    fileprivate func apply(_ properties: [Property<Self>]) {
        properties.forEach({$0.style(self)})
    }
    
}

