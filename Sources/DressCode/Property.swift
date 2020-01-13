//
//  Property.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 24/12/2019.
//  Copyright © 2019 bellots. All rights reserved.
//

import UIKit

public struct Property<Element> {
    let style: (Element) -> Void
}

public extension Property {
    func combine(_ style: Property<Element>) -> Property<Element> {
        return Property<Element> {
            self.style($0)
            style.style($0)
        }
    }
    static func combined(_ properties:Property<Element>...)->Property<Element>{
        properties.reduce(properties.first!, {$0.combine($1)})
    }
}

