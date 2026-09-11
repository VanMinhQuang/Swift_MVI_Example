//
//  CardsState.swift
//  LifeDeck
//

import Foundation

struct CardsState: MVIState {
    // Core data (kept as identifier + snapshot values so State stays a value type)
    var cards: [CardSnapshot] = []

    // Composer
    var newCardTitle: String = ""
    var newCardNote: String = ""

    // Filtering
    var filter: CardsFilter = .all

    // UI state
    var isLoading: Bool = false
    var isAdding: Bool = false
    var errorMessage: String? = nil

    // Derived
    var filteredCards: [CardSnapshot] {
        switch filter {
        case .all: return cards
        case .favorites: return cards.filter { $0.isFavorite }
        }
    }

    var canAddCard: Bool {
        !newCardTitle.trimmed.isEmpty && !isAdding
    }

    var isEmpty: Bool { filteredCards.isEmpty }

    var totalCount: Int { cards.count }
    var favoriteCount: Int { cards.filter { $0.isFavorite }.count }
}

extension CardsState {
    func copy(
        cards: [CardSnapshot]? = nil,
        newCardTitle: String? = nil,
        newCardNote: String? = nil,
        filter: CardsFilter? = nil,
        isLoading: Bool? = nil,
        isAdding: Bool? = nil,
        errorMessage: String?? = nil
    ) -> CardsState {
        var next = self
        if let cards { next.cards = cards }
        if let newCardTitle { next.newCardTitle = newCardTitle }
        if let newCardNote { next.newCardNote = newCardNote }
        if let filter { next.filter = filter }
        if let isLoading { next.isLoading = isLoading }
        if let isAdding { next.isAdding = isAdding }
        if let errorMessage { next.errorMessage = errorMessage }
        return next
    }
}

// Immutable snapshot of a CardItem for use inside State.
struct CardSnapshot: Identifiable, Equatable {
    let id: UUID
    let title: String
    let note: String
    let isFavorite: Bool
    let createdAt: Date
}

extension CardSnapshot {
    init(from card: CardItem) {
        self.id = card.id
        self.title = card.title
        self.note = card.note
        self.isFavorite = card.isFavorite
        self.createdAt = card.createdAt
    }
}
