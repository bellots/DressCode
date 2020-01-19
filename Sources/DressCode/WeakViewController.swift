//
//  WeakViewController.swift
//  
//
//  Created by Andrea Bellotto on 19/01/2020.
//

import UIKit

final class WeakViewController<A: ViewControllerThemeable> {
    weak var unbox: A?
    init(_ value: A) {
        unbox = value
    }
}

struct WeakArray<Element: ViewControllerThemeable> {
    private var items: [WeakViewController<Element>] = []
    
    init(_ elements: [Element]) {
        items = elements.map { WeakViewController($0) }
    }
    
    mutating func append(_ element:Element){
        items.append(WeakViewController(element))
    }
}

extension WeakArray: Collection {
    var startIndex: Int { return items.startIndex }
    var endIndex: Int { return items.endIndex }

    subscript(_ index: Int) -> Element? {
        return items[index].unbox
    }

    func index(after idx: Int) -> Int {
        return items.index(after: idx)
    }
}
