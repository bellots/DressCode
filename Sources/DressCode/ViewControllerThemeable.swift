//
//  ViewControllerThemeable.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import UIKit

/// Protocol required for viewcontroller registered in ThemeFactory
public protocol ViewControllerThemeable:UIViewController {
    
    /// Here setup views' styles of your ViewController defined for your theme.
    /// If you have created a StylableView enum, you can pass this theme through your
    /// StylableView.
    
    func setupStyles(for theme:Themeable)
}
