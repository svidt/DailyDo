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
            Section {
                HStack {
                    if textToEdit == false {
                        Text("\(todo.name)")
                    } else {
                        TextField("Change Name", text: $todo.name)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button {
                        textToEdit.toggle()
                    } label: {
                        Image(systemName: textToEdit ? "checkmark.circle.fill" : "pencil.circle.fill")
                            .foregroundColor(textToEdit ? .green : .purple)
                    }
                    .frame(width: 50, height: 50)
                    
                }
                Toggle(todo.isDone ? "Completed" : "Incomplete", isOn: $todo.isDone)
                
                
            } header: {
                Text(todo.name)
                    .font(.title)
            }
        footer: {
            HStack {
                Text("Added: \(todo.creationDate.formatted(date: .numeric, time: .omitted))")
            }
            .navigationBarTitleDisplayMode(.automatic)
            .navigationTitle("HÝoo")
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


#Preview {
    DetailTodoView(todo: ToDo(name: "Title Name", isDone: false, creationDate: Date(), targetDate: Date()))
}

