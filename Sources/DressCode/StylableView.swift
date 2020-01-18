//
//  StylableView.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation

public protocol StylableView{
    associatedtype View
    
    func style(for theme:Themeable) -> Property<View>
}
