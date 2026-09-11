//
//  SectionCard.swift
//  LifeDeck
//
//  Simple surface container used by the Cards feature list rows.
//

import SwiftUI

struct SectionCard<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(AppTheme.Spacing.lg)
            .background(AppTheme.Colors.surface)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.md))
    }
}
