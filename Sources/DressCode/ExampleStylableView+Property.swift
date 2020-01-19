//
//  Themes.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import UIKit


public extension ExampleStylableView where View:UILabel{
    func style(for theme:Themeable) -> Property<View> {
        switch theme {
        case ExampleThemeable.light:
            switch self {
            case .primary:
                return .color(.black)
            case .secondary:
                return .color(.gray)
            case .accent:
                return .color(.green)
            }
        case ExampleThemeable.dark:
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
        default:
            return .empty()
        }
    }
}

public extension ExampleStylableView where View:UIButton{
    func style(for theme:Themeable) -> Property<View> {
        switch theme {
        case ExampleThemeable.light:
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
        case ExampleThemeable.dark:
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
        default:
            return .empty()
        }
    }
}

