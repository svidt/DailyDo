//
//  DailyDoApp.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 30/07/2023.
//

import SwiftUI
import SwiftData

@main
struct DailyDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DailyDoItem.self)
    }
}
