//
//  Themeable.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import Foundation

/// Protocol used by StylableView to define multiple styles based from your theme
/// Example:
/// enum MyTheme:Themeable{
///     case light
///     case dark
///  static var defaultTheme:Themeable { return .light }
/// }
public protocol Themeable{
    static var defaultTheme: Themeable { get }
}
