//
//  Property.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 24/12/2019.
//  Copyright © 2019 bellots. All rights reserved.
//

import UIKit


/// The property struct which lets to set properties in a declarative way
public struct Property<Element> {
    let style: (Element) -> Void
}

public extension Property {
    
    /// Combines one property to another property
    func combine(_ style: Property<Element>) -> Property<Element> {
        return Property<Element> {
            self.style($0)
            style.style($0)
        }
    }
    
    
    /// Reduce a list of properties to return one merged property
    static func grouped(_ properties:Property<Element>...)->Property<Element>{
        properties.reduce(properties.first!, {$0.combine($1)})
    }
}

