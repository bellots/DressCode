//
//  ExampleThemeable.swift
//  
//
//  Created by Andrea Bellotto on 18/01/2020.
//

import Foundation

public enum ExampleThemeable:Themeable{
    
    public static var defaultTheme: Themeable{
        return Self.light
    }
    
    case light
    case dark
    
}
