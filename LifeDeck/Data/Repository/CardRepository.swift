//
//  CardRepository.swift
//  LifeDeck
//
//  Feature-scoped persistence boundary for the Cards module. Stores and
//  views depend on this protocol instead of DbService/SwiftData directly
//  so business logic stays testable and independent of storage details.
//

import Foundation

@MainActor
protocol CardRepository {
    func fetchAll() throws -> [CardSnapshot]
    func add(title: String, note: String) throws -> CardSnapshot
    func toggleFavorite(id: UUID) throws
    func delete(id: UUID) throws
}
