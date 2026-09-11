//
//  LoadingView.swift
//  LifeDeck
//

import SwiftUI

struct LoadingView: View {
    var message: String = "Loading..."

    var body: some View {
        VStack(spacing: AppTheme.Spacing.md) {
            ProgressView()
            Text(message)
                .font(AppTheme.Fonts.subheadline)
                .foregroundStyle(AppTheme.Colors.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    LoadingView(message: "Loading cards...")
}
