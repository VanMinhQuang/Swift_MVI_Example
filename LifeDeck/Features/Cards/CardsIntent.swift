//
//  CardsIntent.swift
//  LifeDeck
//

import Foundation

enum CardsIntent: MVIIntent {
    // Data lifecycle
    case load
    case refresh

    // New card composer
    case updateNewCardTitle(String)
    case updateNewCardNote(String)
    case addCard

    // Row operations
    case toggleFavorite(UUID)
    case delete(UUID)

    // Filtering
    case changeFilter(CardsFilter)

    // Errors
    case dismissError
}

enum CardsFilter: CaseIterable {
    case all
    case favorites

    var title: String {
        switch self {
        case .all: return "All"
        case .favorites: return "Favorites"
        }
    }
}
