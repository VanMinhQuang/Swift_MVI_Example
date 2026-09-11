//
//  CardItem.swift
//  LifeDeck
//

import Foundation
import SwiftData

@Model
final class CardItem {
    var id: UUID
    var title: String
    var note: String
    var isFavorite: Bool
    var createdAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        note: String = "",
        isFavorite: Bool = false,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.title = title
        self.note = note
        self.isFavorite = isFavorite
        self.createdAt = createdAt
    }
}
