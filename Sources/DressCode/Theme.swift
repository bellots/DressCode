//
//  Theme.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import Foundation

public enum Theme{
    case light
    case dark
}

public enum StyleView<View>:String, CaseIterable{
    case primary
    case secondary
    case accent
    
    func style(for theme:Theme = .light) -> Property<View> {
        return .empty()
    }
}
