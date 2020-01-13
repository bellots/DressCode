//
//  Theme.swift
//  BillyKit
//
//  Created by Andrea Bellotto on 10/01/2020.
//  Copyright © 2020 bellots. All rights reserved.
//

import UIKit

enum StyleTheme:String, CaseIterable{
    case primary
    case primaryBig
    case secondary
    case accent
    case roundedAccent
}

extension Property where Element:UILabel {
    static func style(for styleTheme:StyleTheme) -> Property<Element> {
        switch styleTheme{
        case .primary:
            return combined(
                .color(.black),
                .backgroundColor(.yellow)
            )
        case .primaryBig:
            return combined(
                .style(for: .primary),
                .font(UIFont.systemFont(ofSize: 30))
            )
        case .secondary:
            return combined(
                .color(.gray),
                .backgroundColor(.orange)
            )
        case .accent:
            return combined(
                .color(.orange),
                .backgroundColor(.green)
            )
        case .roundedAccent:
            return combined(
                .style(for: .accent),
                .rounded(5)
            )
        }
    }
}

extension Property where Element:UIButton {
    static func style(for styleTheme:StyleTheme) -> Property<Element> {
        switch styleTheme {
        case .primary:
            return combined(
                .backgroundColor(.black),
                .color(.yellow)
            )
            case .primaryBig:
                return combined(
                    .style(for: .primary),
                    .font(UIFont.systemFont(ofSize: 30))
                )
        case .secondary:
            return combined(
                .backgroundColor(.gray),
                .color(.black)
            )
        case .accent:
            return combined(
                .backgroundColor(.orange),
                .color(.green)
            )
        case .roundedAccent:
            return combined(
                .style(for: .accent),
                .rounded(5)
            )
        }
    }
}
