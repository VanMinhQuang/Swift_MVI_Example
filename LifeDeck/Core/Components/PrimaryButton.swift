//
//  PrimaryButton.swift
//  LifeDeck
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var isLoading: Bool = false
    var isEnabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: AppTheme.Spacing.sm) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(AppTheme.Colors.onPrimary)
                } else if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(AppTheme.Fonts.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.Spacing.md)
            .background(AppTheme.Colors.primary.opacity(isEnabled ? 1 : 0.4))
            .foregroundStyle(AppTheme.Colors.onPrimary)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.Radius.md))
        }
        .disabled(!isEnabled || isLoading)
    }
}

#Preview {
    VStack(spacing: 12) {
        PrimaryButton(title: "Save", systemImage: "checkmark") {}
        PrimaryButton(title: "Loading", isLoading: true) {}
        PrimaryButton(title: "Disabled", isEnabled: false) {}
    }
    .padding()
}
