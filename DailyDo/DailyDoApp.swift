//
//  DailyDoApp.swift
//  DailyDo
//
//  Created by Svidt on 02/07/2023.
//

import SwiftUI

@main
struct DailyDoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
