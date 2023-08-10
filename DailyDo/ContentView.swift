//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 30/07/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DoItem]
    
    var body: some View {
        ZStack {
            Color.gray
        
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        // Code
                    }, label: {
                        AddButton()
                    })

                }
            }
            
            List(items, id: \.self) { item in
                Text("Hello \(item.name)")
            }

            
        }.ignoresSafeArea()
        
//        func addDo() {
//            context.insert(DoItem)
//        }
        
    }
    
}

#Preview {
    ContentView()
}
