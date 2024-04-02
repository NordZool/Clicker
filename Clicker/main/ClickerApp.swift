//
//  ClickerApp.swift
//  Clicker
//
//  Created by admin on 15.02.24.
//

import SwiftUI

@main
struct ClickerApp: App {
    let persistenceController = PersistenceController.shared
    let settings = Settings()

    var body: some Scene {
        WindowGroup {
            ContentView(persistence: persistenceController)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(settings)
        }
    }
}
