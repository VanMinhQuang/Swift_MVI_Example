//
//  HomeView.swift
//  LifeDeck
//
//  Entry screen. Demonstrates the full stack in one place:
//    Data model  (CardItem in Data/Models)
//      └─ Repository (CardRepository / CardRepositoryImpl)
//          └─ DI      (@Environment(\.dependencies))
//              └─ Router (AppRouter.push(.cards, on: .home))
//                  └─ SwiftUI View
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dependencies) private var dependencies
    @EnvironmentObject private var router: AppRouter

    @State private var totalCards: Int = 0
    @State private var favoriteCards: Int = 0

    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.Spacing.lg) {
                header
                cardsTile
            }
            .padding(AppTheme.Spacing.lg)
        }
        .background(AppTheme.Colors.background)
        .navigationTitle("Home")
        .task { await reloadSummary() }
        .refreshable { await reloadSummary() }
    }

    // MARK: - Sections

    private var header: some View {
        VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
            Text("Welcome back")
                .font(AppTheme.Fonts.title)
                .foregroundStyle(AppTheme.Colors.textPrimary)
            Text("Pick up where you left off.")
                .font(AppTheme.Fonts.subheadline)
                .foregroundStyle(AppTheme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cardsTile: some View {
        Button {
            router.push(.cards, on: .home)
        } label: {
            SectionCard {
                HStack(spacing: AppTheme.Spacing.lg) {
                    Image(systemName: AppTab.cards.systemImage)
                        .font(.system(size: 32, weight: .semibold))
                        .foregroundStyle(AppTheme.Colors.primary)
                        .frame(width: 56, height: 56)
                        .background(AppTheme.Colors.primaryMuted)
                        .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.md))

                    VStack(alignment: .leading, spacing: AppTheme.Spacing.xxs) {
                        Text("Cards")
                            .font(AppTheme.Fonts.headline)
                            .foregroundStyle(AppTheme.Colors.textPrimary)
                        Text("\(favoriteCards) favorites · \(totalCards) total")
                            .font(AppTheme.Fonts.footnote)
                            .foregroundStyle(AppTheme.Colors.textSecondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(AppTheme.Colors.textTertiary)
                }
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Data flow

    private func reloadSummary() async {
        let repository = dependencies.makeCardRepository(modelContext)
        do {
            let cards = try repository.fetchAll()
            totalCards = cards.count
            favoriteCards = cards.filter { $0.isFavorite }.count
        } catch {
            totalCards = 0
            favoriteCards = 0
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(AppRouter())
            .environment(\.dependencies, .preview)
            .modelContainer(for: CardItem.self, inMemory: true)
    }
}
