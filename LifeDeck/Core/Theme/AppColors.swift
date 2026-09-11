//
//  AppColors.swift
//  LifeDeck
//
//  Semantic color palette. Values resolve automatically for light/dark
//  system appearance; use these tokens everywhere instead of raw Color.
//

import SwiftUI

enum AppColors {
    // Brand
    static let primary = Color("BrandPrimary", bundle: nil, fallback: Color(red: 0.35, green: 0.45, blue: 0.95))
    static let primaryMuted = primary.opacity(0.15)
    static let accent = Color("BrandAccent", bundle: nil, fallback: Color(red: 0.98, green: 0.65, blue: 0.28))

    // Surfaces
    static let background = Color(.systemBackground)
    static let surface = Color(.secondarySystemBackground)
    static let surfaceElevated = Color(.tertiarySystemBackground)
    static let divider = Color(.separator)

    // Text
    static let textPrimary = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
    static let textTertiary = Color(.tertiaryLabel)
    static let onPrimary = Color.white

    // Semantic
    static let success = Color.green
    static let warning = Color.orange
    static let danger = Color.red
    static let info = Color.blue

    // Legacy alias kept for callers that expect it.
    static let secondary = Color.secondary
}

private extension Color {
    /// Loads a named color from the asset catalog if it exists, otherwise
    /// returns the provided fallback color. Keeps the app rendering even
    /// before the design team ships their palette to Assets.xcassets.
    init(_ name: String, bundle: Bundle?, fallback: Color) {
        if let uiColor = UIColor(named: name, in: bundle, compatibleWith: nil) {
            self = Color(uiColor)
        } else {
            self = fallback
        }
    }
}
