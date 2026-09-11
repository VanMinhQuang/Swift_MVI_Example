//
//  AppTab.swift
//  LifeDeck
//
//  Enumerates the top-level tabs. Owning tab identity as an enum lets
//  AppState persist the selection and the router key its stacks by tab.
//

import SwiftUI

enum AppTab: String, CaseIterable, Identifiable, Hashable {
    case home
    case cards
    case items
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home: return "Home"
        case .cards: return "Cards"
        case .items: return "Items"
        case .settings: return "Settings"
        }
    }

    var systemImage: String {
        switch self {
        case .home: return "house"
        case .cards: return "square.stack.3d.up"
        case .items: return "list.bullet"
        case .settings: return "gearshape"
        }
    }
}
