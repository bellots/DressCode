//
//  Theme.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import Foundation

public protocol ThemeFactoryDelegate:class{
    func didUpdateTheme(to theme: Theme)
}

public struct ThemeFactory{
    public static var defaultTheme:Theme = .light
    
    public var current:Theme {
        didSet{
            delegate?.didUpdateTheme(to: current)
        }
    }
    
    public weak var delegate:ThemeFactoryDelegate?
    
    public init(theme:Theme, delegate:ThemeFactoryDelegate? = nil){
        self.current = theme
        self.delegate = delegate
    }
    
    
}

public enum Theme{
    case light
    case dark
}

public enum StyleView<View>:String, CaseIterable{
    case primary
    case secondary
    case accent
    
    func style(for theme:Theme) -> Property<View> {
        return .empty()
    }
}
