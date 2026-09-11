//
//  Date+Format.swift
//  LifeDeck
//

import Foundation

extension Date {
    func formatted(style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }

    var shortDate: String {
        formatted(style: .short)
    }

    var mediumDate: String {
        formatted(style: .medium)
    }
}
