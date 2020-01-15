//
//  Theme.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import Foundation

public struct ThemeFactory{
    public static var defaultTheme:Theme = .light
    public var current:Theme = .light
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
