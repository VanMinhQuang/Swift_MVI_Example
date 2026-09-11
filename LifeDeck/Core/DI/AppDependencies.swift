//
//  AppDependencies.swift
//  LifeDeck
//
//  Lightweight DI container. Holds factory closures for feature
//  repositories/services so views can resolve them via
//  @Environment(\.dependencies) without importing SwiftData or knowing
//  concrete types.
//
//  Add a new factory here for each new repository, then wire its
//  concrete implementation in the `.live` factory below.
//

import Foundation
import SwiftData

struct AppDependencies: @unchecked Sendable {
    var makeCardRepository: @MainActor (ModelContext) -> CardRepository
}

extension AppDependencies {
    /// Production wiring — resolves each repository against a real
    /// SwiftData-backed DbService built around the given ModelContext.
    static var live: AppDependencies {
        AppDependencies(
            makeCardRepository: { context in
                CardRepositoryImpl(db: SwiftDataDbService(context: context))
            }
        )
    }

    /// Preview/test wiring — repositories keep state in memory and
    /// require no ModelContext.
    static var preview: AppDependencies {
        AppDependencies(
            makeCardRepository: { _ in InMemoryCardRepository() }
        )
    }
}
