//
//  DbService.swift
//  LifeDeck
//
//  Abstraction over persistent storage. Feature stores depend on
//  this protocol instead of touching SwiftData directly so they
//  stay easy to test.
//

import Foundation
import SwiftData

@MainActor
protocol DbService {
    func fetch<T: PersistentModel>(
        _ type: T.Type,
        predicate: Predicate<T>?,
        sortBy: [SortDescriptor<T>]
    ) throws -> [T]

    func insert<T: PersistentModel>(_ model: T) throws
    func delete<T: PersistentModel>(_ model: T) throws
    func save() throws
}

extension DbService {
    func fetch<T: PersistentModel>(_ type: T.Type) throws -> [T] {
        try fetch(type, predicate: nil, sortBy: [])
    }

    func fetch<T: PersistentModel>(
        _ type: T.Type,
        sortBy: [SortDescriptor<T>]
    ) throws -> [T] {
        try fetch(type, predicate: nil, sortBy: sortBy)
    }
}
