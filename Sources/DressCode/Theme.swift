//
//  Theme.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import Foundation
import UIKit


public protocol Themeable{
    static var defaultTheme: Themeable { get }
}

public enum Theme:Themeable{
    
    public static var defaultTheme: Themeable{
        return Self.light
    }
    
    case light
    case dark
    
}

public protocol StylableView{
    associatedtype View
    
    func style(for theme:Themeable) -> Property<View>
}

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
