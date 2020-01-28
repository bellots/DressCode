//
//  WeakBox.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

/// struct useful to keep weak references in a Swift array
struct WeakBox {
    
    weak var reference: ViewControllerThemeable?

    init(_ reference: @autoclosure () -> ViewControllerThemeable) {
        self.reference = reference()
    }
    
    var isEmpty: Bool {
        self.reference == nil
    }
}
