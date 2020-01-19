//
//  ViewControllerThemeable.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import UIKit

public protocol ViewControllerThemeable:UIViewController {
    func setupStyles(for theme:Themeable)
}

extension UIViewController:ViewControllerThemeable{
    public func setupStyles(for theme: Themeable) {
        
    }
}
