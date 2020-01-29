//
//  ThemeFactory.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation
import UIKit



/// Theme factory is the theme manager. It keeps memory of the current Themeable,
/// and on update it has 2 ways to update views inside your viewController:
/// 1 - through delegation, but it can link only one ViewController per ThemeFactory
/// 2 - by registering your ViewController to themeFactory (your ViewController has to extend
///     ViewControllerThemeable protocol).

public protocol ThemeFactoryDelegate:class{
    func didUpdateTheme(to theme: Themeable)
}

public class ThemeFactory<Theme:Themeable>{
    
    public var current:Theme {
        didSet{
            viewControllerToUpdate.forEach({$0.reference?.setupStyles(for: current)})
            delegate?.didUpdateTheme(to: current)
        }
    }
    
    public weak var delegate:ThemeFactoryDelegate?
    private weak var window:UIWindow?

    
    /// Refresh uiwindow children's component style
    public func refresh(window:UIWindow){
        for view in window.subviews {
            view.removeFromSuperview()
            window.addSubview(view)
        }
    }
    
    /// Init with required Themeable and an optional delegate
    /// - Parameters:
    ///   - theme: Themeable component
    ///   - delegate: delegate which listen for updates (has to be a class). Optional.
    public init(theme:Theme, delegate:ThemeFactoryDelegate? = nil){
        self.current = theme
        self.delegate = delegate
        self.viewControllerToUpdate = [WeakBox]()
    }

    /// Init with required Themeable and a ViewControllerThemeable
    /// - Parameters:
    ///   - theme: Themeable component
    ///   - delegate: ViewControllerDelegate ViewController
    
    public init(theme:Theme, viewControllerToUpdate:ViewControllerThemeable){
        self.current = theme
        self.viewControllerToUpdate = [WeakBox(viewControllerToUpdate)]
    }
    
    
    /// This WeakBox array keeps WEAKLY memory of your ViewControllerThemeables
    var viewControllerToUpdate = [WeakBox]()
    
    
    /// Register ViewControllerThemeable to themeFactory. If needed you can force
    /// ViewController children's style.
    public func registerUpdates(for viewController:ViewControllerThemeable, setuppingStyle setupStyle:Bool = true) {
        viewControllerToUpdate.append(WeakBox(viewController))
        if setupStyle {
            viewController.setupStyles(for: current)
        }
    }
    
    
    /// Update style for every viewControllerThemeable
    public func setupStyles(){
        viewControllerToUpdate.forEach({$0.reference?.setupStyles(for: current)})
    }
}
