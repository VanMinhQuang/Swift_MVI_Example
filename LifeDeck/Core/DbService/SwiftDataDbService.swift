//
//  SwiftDataDbService.swift
//  LifeDeck
//
//  SwiftData-backed implementation of DbService.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataDbService: DbService {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func fetch<T: PersistentModel>(
        _ type: T.Type,
        predicate: Predicate<T>?,
        sortBy: [SortDescriptor<T>]
    ) throws -> [T] {
        var descriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        descriptor.includePendingChanges = true
        return try context.fetch(descriptor)
    }

    func insert<T: PersistentModel>(_ model: T) throws {
        context.insert(model)
        try save()
    }

    func delete<T: PersistentModel>(_ model: T) throws {
        context.delete(model)
        try save()
    }

    func save() throws {
        guard context.hasChanges else { return }
        try context.save()
    }
}
