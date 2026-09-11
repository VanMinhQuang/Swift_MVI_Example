//
//  InMemoryCardRepository.swift
//  LifeDeck
//
//  Lightweight CardRepository used as a preview/test default before a
//  real ModelContext is available. Keeps CardsStore usable in previews
//  without spinning up SwiftData.
//

import Foundation

@MainActor
final class InMemoryCardRepository: CardRepository {
    private var cards: [CardSnapshot]

    init(seed: [CardSnapshot] = []) {
        self.cards = seed
    }

    func fetchAll() throws -> [CardSnapshot] {
        cards.sorted { $0.createdAt > $1.createdAt }
    }

    func add(title: String, note: String) throws -> CardSnapshot {
        let snapshot = CardSnapshot(
            id: UUID(),
            title: title,
            note: note,
            isFavorite: false,
            createdAt: Date()
        )
        cards.append(snapshot)
        return snapshot
    }

    func toggleFavorite(id: UUID) throws {
        guard let index = cards.firstIndex(where: { $0.id == id }) else { return }
        let current = cards[index]
        cards[index] = CardSnapshot(
            id: current.id,
            title: current.title,
            note: current.note,
            isFavorite: !current.isFavorite,
            createdAt: current.createdAt
        )
    }

    func delete(id: UUID) throws {
        cards.removeAll { $0.id == id }
    }
}
