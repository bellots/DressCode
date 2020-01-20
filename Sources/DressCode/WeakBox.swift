//
//  WeakBox.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

struct WeakBox {
    
    weak var reference: ViewControllerThemeable?

    init(_ reference: @autoclosure () -> ViewControllerThemeable) {
        self.reference = reference()
    }
    
    var isEmpty: Bool {
        self.reference == nil
    }
}
