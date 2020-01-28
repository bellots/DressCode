//
//  StylableView.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation


/// Protocol required to extend your enum, classes or structs and which lets you
/// to create your own styles and apply it in different places without repeat
/// properties.

public protocol StylableView{
    associatedtype View
    
    func style(for theme:Themeable) -> Property<View>
}

public extension StylableView{
    
    /// Default stylable extension
    /// NOTE that every view that is not extended in your style, will call this
    /// .empty() property
    
    func style(for theme: Themeable) -> Property<View> {
        return .empty()
    }
}
