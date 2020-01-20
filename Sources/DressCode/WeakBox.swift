//
//  WeakBox.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

struct WeakBox<T: AnyObject> {
    
    weak var reference: T?

    init(_ reference: @autoclosure () -> T) {
        self.reference = reference()
    }
    
    var isEmpty: Bool {
        self.reference == nil
    }
}
