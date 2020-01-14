//
//  Themes.swift
//  
//
//  Created by Andrea Bellotto on 14/01/2020.
//

import UIKit

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
                    .backgroundColor(.green),
                    .color(.white)
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
                    .backgroundColor(.green),
                    .color(.white)
                )
            }
        }
    }
}

