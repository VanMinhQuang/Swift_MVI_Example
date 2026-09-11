//
//  AppFonts.swift
//  LifeDeck
//
//  Typography scale. Prefer these tokens over raw Font values so text
//  styles stay consistent across screens.
//

import SwiftUI

enum AppFonts {
    // Display
    static let largeTitle = Font.system(.largeTitle, design: .rounded).weight(.bold)
    static let title = Font.system(.title, design: .rounded).weight(.semibold)
    static let title2 = Font.system(.title2, design: .rounded).weight(.semibold)
    static let title3 = Font.system(.title3, design: .rounded).weight(.semibold)

    // Body
    static let headline = Font.headline
    static let body = Font.body
    static let bodyEmphasized = Font.body.weight(.semibold)
    static let callout = Font.callout
    static let subheadline = Font.subheadline

    // Support
    static let footnote = Font.footnote
    static let caption = Font.caption
    static let caption2 = Font.caption2

    /// Escape hatch for custom scaled fonts. Falls back to the system
    /// font when the named font isn't installed.
    static func custom(_ name: String, size: CGFloat, relativeTo style: Font.TextStyle = .body) -> Font {
        Font.custom(name, size: size, relativeTo: style)
    }
}
