//
//  AppTheme.swift
//  LifeDeck
//
//  Central access point for theme tokens plus the user-facing theme mode
//  (system / light / dark) that AppState persists.
//

import SwiftUI

enum AppTheme {
    typealias Colors = AppColors
    typealias Fonts = AppFonts
    typealias Spacing = AppSpacing
    typealias Radius = AppRadius
}

enum AppThemeMode: String, CaseIterable, Identifiable, Codable {
    case system
    case light
    case dark

    var id: String { rawValue }

    var title: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
