//
//  DetailTodoView.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI

struct DetailTodoView: View {
    
    @Bindable var todo: ToDo
    @State private var textToEdit = false
    
    var body: some View {
        
        VStack {
            
            List {
                Section {
                    HStack {
                        TextField("Change Name", text: $todo.name)
                            .textFieldStyle(.roundedBorder)
                        
                    }
                    
                    // Insert calender
                    
                } header: {
                    Text("Details")
                }
                
                Button("Delete", role: .destructive) {
                    // Code
                }
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("\(todo.name)")
            
        }
    }
}


//#Preview {
//    DetailTodoView(todo: ToDo(name: "Preview Name", isDone: true, creationDate: .now, targetDate: .distantFuture))
//}

