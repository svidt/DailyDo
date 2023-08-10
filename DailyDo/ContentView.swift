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
                        /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                            .padding(30)
                            .foregroundColor(.white)
                            .background(.blue)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 20)
                        
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
