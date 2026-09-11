//
//  AppState.swift
//  LifeDeck
//
//  Global, cross-feature app state. Injected into the environment at the
//  root so any screen can read/write shared concerns like theme mode
//  and the currently selected tab.
//

import Combine
import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var selectedTab: AppTab {
        didSet { defaults.set(selectedTab.rawValue, forKey: Keys.selectedTab) }
    }

    @Published var themeMode: AppThemeMode {
        didSet { defaults.set(themeMode.rawValue, forKey: Keys.themeMode) }
    }

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        let storedTab = defaults.string(forKey: Keys.selectedTab).flatMap(AppTab.init(rawValue:))
        self.selectedTab = storedTab ?? .home
        let storedMode = defaults.string(forKey: Keys.themeMode).flatMap(AppThemeMode.init(rawValue:))
        self.themeMode = storedMode ?? .system
    }

    private enum Keys {
        static let selectedTab = "AppState.selectedTab"
        static let themeMode = "AppState.themeMode"
    }
}
