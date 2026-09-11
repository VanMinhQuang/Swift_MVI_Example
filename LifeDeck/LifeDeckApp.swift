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
        }
        .modelContainer(sharedModelContainer)
    }
}

struct RootTabView: View {
    var body: some View {
        TabView {
            CardsView()
                .tabItem {
                    Label("Cards", systemImage: "square.stack.3d.up")
                }
            ContentView()
                .tabItem {
                    Label("Items", systemImage: "list.bullet")
                }
        }
    }
}
