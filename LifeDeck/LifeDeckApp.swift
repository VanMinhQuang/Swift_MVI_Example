//
//  LifeDeckApp.swift
//  LifeDeck
//
//  Created by Macbook on 11/9/26.
//

import SwiftUI
import SwiftData

@main
struct LifeDeckApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var router = AppRouter()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            CardItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(\.dependencies, .live)
                .environmentObject(appState)
                .environmentObject(router)
                .preferredColorScheme(appState.themeMode.colorScheme)
                .tint(AppTheme.Colors.primary)
        }
        .modelContainer(sharedModelContainer)
    }
}
