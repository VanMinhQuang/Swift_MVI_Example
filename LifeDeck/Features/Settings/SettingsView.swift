//
//  SettingsView.swift
//  LifeDeck
//
//  Minimal settings screen. Exposes the theme mode picker so users can
//  override system appearance. Extend as features land.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Form {
            Section("Appearance") {
                Picker("Theme", selection: $appState.themeMode) {
                    ForEach(AppThemeMode.allCases) { mode in
                        Text(mode.title).tag(mode)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
            .environmentObject(AppState())
    }
}
