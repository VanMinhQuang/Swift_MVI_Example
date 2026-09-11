//
//  Logger.swift
//  LifeDeck
//
//  Thin wrapper around OSLog for consistent, categorized logging.
//

import Foundation
import OSLog

enum AppLogger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "LifeDeck"

    static let ui = Logger(subsystem: subsystem, category: "ui")
    static let db = Logger(subsystem: subsystem, category: "db")
    static let store = Logger(subsystem: subsystem, category: "store")
}
