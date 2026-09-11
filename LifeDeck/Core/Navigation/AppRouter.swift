//
//  AppRouter.swift
//  LifeDeck
//
//  Holds one NavigationPath per tab so each tab's stack survives tab
//  switches. Features push/pop by asking the router instead of owning
//  their own NavigationStack state.
//

import Combine
import SwiftUI

@MainActor
final class AppRouter: ObservableObject {
    @Published var paths: [AppTab: NavigationPath] = [:]

    func path(for tab: AppTab) -> Binding<NavigationPath> {
        Binding(
            get: { [weak self] in
                self?.paths[tab] ?? NavigationPath()
            },
            set: { [weak self] newValue in
                self?.paths[tab] = newValue
            }
        )
    }

    func push(_ route: AppRoute, on tab: AppTab) {
        var path = paths[tab] ?? NavigationPath()
        path.append(route)
        paths[tab] = path
    }

    func pop(on tab: AppTab) {
        guard var path = paths[tab], !path.isEmpty else { return }
        path.removeLast()
        paths[tab] = path
    }

    func popToRoot(on tab: AppTab) {
        paths[tab] = NavigationPath()
    }
}
