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

public class ThemeFactory<Theme:Themeable>{
    
    public var current:Theme {
        didSet{
            viewControllerToUpdate.forEach({$0.reference?.setupStyles(for: current)})
            delegate?.didUpdateTheme(to: current)
            for window in UIApplication.shared.windows {
                for view in window.subviews {
                    view.removeFromSuperview()
                    window.addSubview(view)
                }
            }
        }
    }
    
    public weak var delegate:ThemeFactoryDelegate?
    
    public init(theme:Theme, delegate:ThemeFactoryDelegate? = nil){
        self.current = theme
        self.delegate = delegate
        self.viewControllerToUpdate = [WeakBox]()
    }

    public init(theme:Theme, viewControllerToUpdate:ViewControllerThemeable){
        self.current = theme
        self.viewControllerToUpdate = [WeakBox(viewControllerToUpdate)]
    }
    
    var viewControllerToUpdate = [WeakBox]()
    
    public func registerUpdates(for viewController:ViewControllerThemeable, setuppingStyle setupStyle:Bool = true) {
        viewControllerToUpdate.append(WeakBox(viewController))
        if setupStyle {
            viewController.setupStyles(for: current)
        }
    }
    
    public func setupStyles(){
        viewControllerToUpdate.forEach({$0.reference?.setupStyles(for: current)})
    }
}
