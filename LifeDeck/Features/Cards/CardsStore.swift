//
//  CardsStore.swift
//  LifeDeck
//

import Combine
import Foundation
import OSLog
import SwiftData
import SwiftUI

@MainActor
final class CardsStore: MVIStore {
    @Published private(set) var state = CardsState()

    private var db: DbService

    init(db: DbService) {
        self.db = db
    }

    /// Swap in a new persistence backend (e.g. once the environment
    /// ModelContext becomes available in a `.task` block).
    func configure(db: DbService) {
        self.db = db
    }

    // MARK: - Bindings

    var newCardTitleBinding: Binding<String> {
        Binding(
            get: { self.state.newCardTitle },
            set: { self.send(.updateNewCardTitle($0)) }
        )
    }

    var newCardNoteBinding: Binding<String> {
        Binding(
            get: { self.state.newCardNote },
            set: { self.send(.updateNewCardNote($0)) }
        )
    }

    var filterBinding: Binding<CardsFilter> {
        Binding(
            get: { self.state.filter },
            set: { self.send(.changeFilter($0)) }
        )
    }

    // MARK: - Intent dispatch

    func send(_ intent: CardsIntent) {
        switch intent {
        case .load: handleLoad()
        case .refresh: handleRefresh()
        case .updateNewCardTitle(let title): state = state.copy(newCardTitle: title)
        case .updateNewCardNote(let note): state = state.copy(newCardNote: note)
        case .addCard: handleAddCard()
        case .toggleFavorite(let id): handleToggleFavorite(id)
        case .delete(let id): handleDelete(id)
        case .changeFilter(let filter): state = state.copy(filter: filter)
        case .dismissError: state = state.copy(errorMessage: .some(nil))
        }
    }

    // MARK: - Handlers

    private func handleLoad() {
        guard !state.isLoading else { return }
        state = state.copy(isLoading: true, errorMessage: .some(nil))
        do {
            let items = try fetchAll()
            state = state.copy(cards: items.map(CardSnapshot.init), isLoading: false)
        } catch {
            AppLogger.store.error("Load cards failed: \(error.localizedDescription, privacy: .public)")
            state = state.copy(isLoading: false, errorMessage: .some(error.localizedDescription))
        }
    }

    private func handleRefresh() {
        do {
            let items = try fetchAll()
            state = state.copy(cards: items.map(CardSnapshot.init))
        } catch {
            state = state.copy(errorMessage: .some(error.localizedDescription))
        }
    }

    private func handleAddCard() {
        guard state.canAddCard else { return }
        let title = state.newCardTitle.trimmed
        let note = state.newCardNote.trimmed
        state = state.copy(isAdding: true)
        do {
            let newCard = CardItem(title: title, note: note)
            try db.insert(newCard)
            let items = try fetchAll()
            state = state.copy(
                cards: items.map(CardSnapshot.init),
                newCardTitle: "",
                newCardNote: "",
                isAdding: false
            )
        } catch {
            AppLogger.store.error("Add card failed: \(error.localizedDescription, privacy: .public)")
            state = state.copy(isAdding: false, errorMessage: .some(error.localizedDescription))
        }
    }

    private func handleToggleFavorite(_ id: UUID) {
        do {
            let all = try fetchAll()
            guard let target = all.first(where: { $0.id == id }) else { return }
            target.isFavorite.toggle()
            try db.save()
            let items = try fetchAll()
            state = state.copy(cards: items.map(CardSnapshot.init))
        } catch {
            state = state.copy(errorMessage: .some(error.localizedDescription))
        }
    }

    private func handleDelete(_ id: UUID) {
        do {
            let all = try fetchAll()
            guard let target = all.first(where: { $0.id == id }) else { return }
            try db.delete(target)
            let items = try fetchAll()
            state = state.copy(cards: items.map(CardSnapshot.init))
        } catch {
            state = state.copy(errorMessage: .some(error.localizedDescription))
        }
    }

    // MARK: - Helpers

    private func fetchAll() throws -> [CardItem] {
        try db.fetch(
            CardItem.self,
            sortBy: [SortDescriptor(\CardItem.createdAt, order: .reverse)]
        )
    }
}
