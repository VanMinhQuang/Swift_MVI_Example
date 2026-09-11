//
//  AppRoute.swift
//  LifeDeck
//
//  Type-safe destinations pushed onto a tab's NavigationStack. Add a
//  case per screen, then handle it in RootTabView's navigationDestination.
//

import Foundation

enum AppRoute: Hashable {
    case cards
    case cardDetail(UUID)
    case itemDetail(UUID)
    case settings
}
