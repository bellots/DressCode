//
//  ThemeFactory.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation
import UIKit

public protocol ThemeFactoryDelegate:class{
    func didUpdateTheme(to theme: Themeable)
}

public struct ThemeFactory<Theme:Themeable>{
    
    public var current:Theme {
        didSet{
            viewControllerToUpdate.forEach({$0.setupStyles(for: current)})
            delegate?.didUpdateTheme(to: current)
        }
    }
    
    public weak var delegate:ThemeFactoryDelegate?
    
    public init(theme:Theme, delegate:ThemeFactoryDelegate? = nil){
        self.current = theme
        self.delegate = delegate
        self.viewControllerToUpdate = [ViewControllerThemeable]()
    }

    public init(theme:Theme, viewControllerToUpdate:ViewControllerThemeable){
        self.current = theme
        self.viewControllerToUpdate = [viewControllerToUpdate]
    }
    
    var viewControllerToUpdate:[ViewControllerThemeable]
    
    mutating func registerUpdates(for viewController:ViewControllerThemeable) {
        viewControllerToUpdate.append(viewController)
    }
}
