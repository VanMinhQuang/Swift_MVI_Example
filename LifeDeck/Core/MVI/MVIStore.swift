//
//  MVIStore.swift
//  LifeDeck
//
//  Base protocol for the MVI pattern. A store owns the immutable
//  State, receives Intents from the view, and produces new State.
//

import Foundation

@MainActor
protocol MVIStore: ObservableObject {
    associatedtype State
    associatedtype Intent

    var state: State { get }
    func send(_ intent: Intent)
}
