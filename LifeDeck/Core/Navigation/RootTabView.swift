//
//  RootTabView.swift
//  LifeDeck
//
//  Root shell: renders one NavigationStack per AppTab, bound to the
//  router's per-tab path, and resolves shared AppRoute destinations.
//

import SwiftUI

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var router: AppRouter

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            tab(.home) { HomeView() }
            tab(.cards) { CardsView() }
            tab(.settings) { SettingsView() }
        }
        .tint(AppTheme.Colors.primary)
    }

    @ViewBuilder
    private func tab<Content: View>(_ tab: AppTab, @ViewBuilder content: () -> Content) -> some View {
        NavigationStack(path: router.path(for: tab)) {
            content()
                .navigationDestination(for: AppRoute.self) { route in
                    destination(for: route)
                }
        }
        .tabItem { Label(tab.title, systemImage: tab.systemImage) }
        .tag(tab)
    }

    @ViewBuilder
    private func destination(for route: AppRoute) -> some View {
        switch route {
        case .cards:
            CardsView()
        case .cardDetail(let id):
            Text("Card \(id.uuidString)")
                .navigationTitle("Card")
        case .itemDetail(let id):
            Text("Item \(id.uuidString)")
                .navigationTitle("Item")
        case .settings:
            SettingsView()
        }
    }
}
