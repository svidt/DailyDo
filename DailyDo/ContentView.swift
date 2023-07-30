//
//  ContentView.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 30/07/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DailyDoItem]
    
    var body: some View {
        VStack {

            Text("Tap on this button")
            Button("Add DailyDo") {
                addDailyDo()
            }
            
            List {
                ForEach(items) { item in
                    Text(item.name)
                }
            }
            
        }
        .padding()
    }
    
    func addDailyDo() {
        // Create the item
        let item = DailyDoItem(name: "Text Item")
        
        // Add the item to the data context
        context.insert(item)
        
    }
    
}

#Preview {
    ContentView()
}
