//
//  Themes.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import UIKit

public extension StyleView where View:UILabel{
    func applyStyle(for theme:Theme = ThemeFactory.current, to views:View...){
        views.forEach({$0.setStyle(self.style(for: theme))})
    }
}

public extension StyleView where View:UIButton{
    func applyStyle(for theme:Theme = ThemeFactory.current, to views:View...){
        views.forEach({$0.setStyle(self.style(for: theme))})
    }
}


public extension UILabel{
    func setStyle(_ styleView:StyleView<UILabel>, for theme:Theme = ThemeFactory.current){
        setStyle(styleView.style(for: theme))
    }
}

public extension UIButton{
    func setStyle(_ styleView:StyleView<UIButton>, for theme:Theme = ThemeFactory.current){
        setStyle(styleView.style(for: theme))
    }
}


public extension StyleView where View:UILabel{
    func style(for theme:Theme) -> Property<View> {
        switch theme {
        case .light:
            switch self {
            case .primary:
                return .color(.black)
            case .secondary:
                return .color(.gray)
            case .accent:
                return .color(.green)
            }
        case .dark:
            switch self {
            case .primary:
                return .color(.white)
            case .secondary:
                return .combined(
                    .backgroundColor(.white),
                    .color(.gray)
                )
            case .accent:
                return .combined(
                    .backgroundColor(.white),
                    .color(.green)
                )
            }
        }
    }
}

public extension StyleView where View:UIButton{
    func style(for theme:Theme) -> Property<View> {
        switch theme {
        case .light:
            switch self {
            case .primary:
                return .combined(
                    .backgroundColor(.white),
                    .color(.black)
                )
            case .secondary:
                return .combined(
                    .backgroundColor(.white),
                    .color(.gray)
                )
            case .accent:
                return .combined(
                    .backgroundColor(.white),
                    .color(.green)
                )
            }
        case .dark:
            switch self {
            case .primary:
                return .combined(
                    .backgroundColor(.white),
                    .color(.black)
                )
            case .secondary:
                return .combined(
                    .backgroundColor(.gray),
                    .color(.black)
                )
            case .accent:
                return .combined(
                    .backgroundColor(.green),
                    .color(.white)
                )
            }
        }
    }
}

