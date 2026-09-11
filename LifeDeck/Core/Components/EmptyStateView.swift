//
//  EmptyStateView.swift
//  LifeDeck
//

import SwiftUI

struct EmptyStateView: View {
    let systemImage: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            Image(systemName: systemImage)
                .font(.system(size: 44, weight: .regular))
                .foregroundStyle(AppTheme.Colors.secondary)
            Text(title)
                .font(AppTheme.Fonts.title2)
                .foregroundStyle(AppTheme.Colors.textPrimary)
            Text(message)
                .font(AppTheme.Fonts.subheadline)
                .foregroundStyle(AppTheme.Colors.textSecondary)
                .multilineTextAlignment(.center)
        }
        .padding(AppTheme.Spacing.xl)
    }
}

#Preview {
    EmptyStateView(
        systemImage: "square.stack.3d.up",
        title: "No cards yet",
        message: "Add your first card to start building your deck."
    )
}
