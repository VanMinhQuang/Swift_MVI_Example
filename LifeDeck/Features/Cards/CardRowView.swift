//
//  CardRowView.swift
//  LifeDeck
//

import SwiftUI

struct CardRowView: View {
    let card: CardSnapshot
    let onToggleFavorite: () -> Void
    let onDelete: () -> Void

    var body: some View {
        SectionCard {
            HStack(alignment: .top, spacing: AppTheme.Spacing.md) {
                VStack(alignment: .leading, spacing: AppTheme.Spacing.xs) {
                    Text(card.title)
                        .font(AppTheme.Fonts.headline)
                        .foregroundStyle(AppTheme.Colors.textPrimary)
                    if !card.note.isEmpty {
                        Text(card.note)
                            .font(AppTheme.Fonts.subheadline)
                            .foregroundStyle(AppTheme.Colors.textSecondary)
                            .lineLimit(3)
                    }
                    Text(card.createdAt.mediumDate)
                        .font(AppTheme.Fonts.caption)
                        .foregroundStyle(AppTheme.Colors.textSecondary)
                }
                Spacer(minLength: 0)
                Button(action: onToggleFavorite) {
                    Image(systemName: card.isFavorite ? "star.fill" : "star")
                        .font(.title3)
                        .foregroundStyle(card.isFavorite ? AppTheme.Colors.warning : AppTheme.Colors.secondary)
                }
                .buttonStyle(.plain)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .listRowInsets(EdgeInsets(top: AppTheme.Spacing.xs, leading: AppTheme.Spacing.lg, bottom: AppTheme.Spacing.xs, trailing: AppTheme.Spacing.lg))
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

#Preview {
    List {
        CardRowView(
            card: CardSnapshot(
                id: UUID(),
                title: "Morning routine",
                note: "Meditate for 10 minutes and plan the day.",
                isFavorite: true,
                createdAt: Date()
            ),
            onToggleFavorite: {},
            onDelete: {}
        )
    }
    .listStyle(.plain)
}
