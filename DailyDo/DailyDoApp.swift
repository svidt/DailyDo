//
//  DailyDoApp.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 16/08/2023.
//

import SwiftUI
import SwiftData

@main
struct DailyDoApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
