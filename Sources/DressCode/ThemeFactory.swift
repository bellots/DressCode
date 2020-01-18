//
//  ThemeFactory.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation

public protocol ThemeFactoryDelegate:class{
    func didUpdateTheme(to theme: Themeable)
}

public struct ThemeFactory{
    
    public var current:Themeable {
        didSet{
            delegate?.didUpdateTheme(to: current)
        }
    }
    
    public weak var delegate:ThemeFactoryDelegate?
    
    public init(theme:Themeable, delegate:ThemeFactoryDelegate? = nil){
        self.current = theme
        self.delegate = delegate
    }

}
