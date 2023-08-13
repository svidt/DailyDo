//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 30/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {

        NavigationView {
            
            List {
                Text("Test data")
            }
            .navigationTitle("DailyDo's")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                // Code Add
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
