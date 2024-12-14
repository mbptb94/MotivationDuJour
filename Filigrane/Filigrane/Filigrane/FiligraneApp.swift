//
//  FiligraneApp.swift
//  Filigrane
//
//  Created by Yoann TOURTELLIER on 12/12/2024.
//

import SwiftUI
import SwiftData

@main
struct FiligraneApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Watermark.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
