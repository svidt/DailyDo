//
//  DetailTodoView.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 17/08/2023.
//

import SwiftUI

struct DetailTodoView: View {
    
    @Bindable var todo: ToDo
    
    var body: some View {
        VStack {
            Section { 
                TextField("Change Name", text: $todo.name)
                    .textFieldStyle(.roundedBorder)
                Toggle(todo.isDone ? "Completed" : "Incomplete", isOn: $todo.isDone)
                
                
            } header: {
                Text(todo.name)
                    .font(.title)
            }
        footer: {
            HStack {
                Text("Added: \(todo.creationDate.formatted(date: .numeric, time: .omitted))")
            }
            HStack {
                Text("Completed: ")
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isDone ? .green : .gray)
            }
            Text("Remind me at:")
        }
            
            
        }
        .padding(5)
    }
}


//#Preview {
//    DetailTodoView(todo: ToDo(name: "Preview name"))
//}

