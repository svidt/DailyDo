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
            
            let context = persistenceController.container.viewContext
            let dateHolder = DateHolder(context)
            
            DailyDoView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dateHolder)
        }
    }
}
