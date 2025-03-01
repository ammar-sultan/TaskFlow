//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Ammar on 2025-02-15.
//

import SwiftUI

@main
struct TaskFlowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            SplashScreenView() // Show the splash screen initially
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

