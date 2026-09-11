//
//  EnvironmentValues+Dependencies.swift
//  LifeDeck
//
//  Exposes AppDependencies via SwiftUI's environment so any view can
//  resolve feature repositories with @Environment(\.dependencies).
//

import SwiftUI

private struct AppDependenciesKey: EnvironmentKey {
    static let defaultValue: AppDependencies = .live
}

extension EnvironmentValues {
    var dependencies: AppDependencies {
        get { self[AppDependenciesKey.self] }
        set { self[AppDependenciesKey.self] = newValue }
    }
}
