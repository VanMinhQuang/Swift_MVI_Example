//
//  CardsView.swift
//  LifeDeck
//
//  MVI-driven cards screen: the View only reads state and sends
//  intents — all mutations happen inside CardsStore.
//

import SwiftData
import SwiftUI

struct CardsView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var store = CardsStore(db: CardsView.makePreviewDb())

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Cards")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Text("\(store.state.favoriteCount)/\(store.state.totalCount)")
                            .font(AppTheme.Fonts.footnote)
                            .foregroundStyle(AppTheme.Colors.textSecondary)
                    }
                }
                .alert(
                    "Something went wrong",
                    isPresented: Binding(
                        get: { store.state.errorMessage != nil },
                        set: { if !$0 { store.send(.dismissError) } }
                    ),
                    presenting: store.state.errorMessage
                ) { _ in
                    Button("OK") { store.send(.dismissError) }
                } message: { message in
                    Text(message)
                }
        }
        .task {
            store.configure(db: SwiftDataDbService(context: modelContext))
            store.send(.load)
        }
    }

    @ViewBuilder
    private var content: some View {
        if store.state.isLoading {
            LoadingView(message: "Loading cards...")
        } else {
            VStack(spacing: AppTheme.Spacing.lg) {
                filterPicker
                if store.state.isEmpty {
                    EmptyStateView(
                        systemImage: "square.stack.3d.up",
                        title: "No cards yet",
                        message: "Add your first card below to start building your deck."
                    )
                    .frame(maxHeight: .infinity)
                } else {
                    cardList
                }
                composer
            }
            .padding(.vertical, AppTheme.Spacing.md)
        }
    }

    private var filterPicker: some View {
        Picker("Filter", selection: store.filterBinding) {
            ForEach(CardsFilter.allCases, id: \.self) { filter in
                Text(filter.title).tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    private var cardList: some View {
        List {
            ForEach(store.state.filteredCards) { card in
                CardRowView(
                    card: card,
                    onToggleFavorite: { store.send(.toggleFavorite(card.id)) },
                    onDelete: { store.send(.delete(card.id)) }
                )
            }
        }
        .listStyle(.plain)
        .refreshable { store.send(.refresh) }
    }

    private var composer: some View {
        VStack(spacing: AppTheme.Spacing.sm) {
            TextField("Card title", text: store.newCardTitleBinding)
                .textFieldStyle(.roundedBorder)
            TextField("Notes (optional)", text: store.newCardNoteBinding, axis: .vertical)
                .lineLimit(1...3)
                .textFieldStyle(.roundedBorder)
            PrimaryButton(
                title: "Add Card",
                systemImage: "plus.circle.fill",
                isLoading: store.state.isAdding,
                isEnabled: store.state.canAddCard
            ) {
                store.send(.addCard)
            }
        }
        .padding(.horizontal, AppTheme.Spacing.lg)
    }

    // MARK: - Preview / bootstrap

    private static func makePreviewDb() -> DbService {
        do {
            let container = try ModelContainer(
                for: CardItem.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            return SwiftDataDbService(context: ModelContext(container))
        } catch {
            fatalError("Failed to bootstrap CardsView preview DB: \(error)")
        }
    }
}

#Preview {
    CardsView()
        .modelContainer(for: CardItem.self, inMemory: true)
}
