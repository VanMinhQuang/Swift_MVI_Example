//
//  CardRepositoryImpl.swift
//  LifeDeck
//
//  Default CardRepository backed by DbService (SwiftData in production).
//

import Foundation
import SwiftData

@MainActor
final class CardRepositoryImpl: CardRepository {
    private let db: DbService

    init(db: DbService) {
        self.db = db
    }

    func fetchAll() throws -> [CardSnapshot] {
        try db.fetch(
            CardItem.self,
            sortBy: [SortDescriptor(\CardItem.createdAt, order: .reverse)]
        )
        .map(CardSnapshot.init)
    }

    func add(title: String, note: String) throws -> CardSnapshot {
        let item = CardItem(title: title, note: note)
        try db.insert(item)
        return CardSnapshot(from: item)
    }

    func toggleFavorite(id: UUID) throws {
        guard let target = try findItem(id: id) else { return }
        target.isFavorite.toggle()
        try db.save()
    }

    func delete(id: UUID) throws {
        guard let target = try findItem(id: id) else { return }
        try db.delete(target)
    }

    private func findItem(id: UUID) throws -> CardItem? {
        try db.fetch(CardItem.self).first(where: { $0.id == id })
    }
}
