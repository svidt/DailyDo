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
                    Text("First item in first section")
                    Text("Second item in first section")
                } header: {
                    Text("\(todo.name)")
                }
                
                Section {
                    Toggle(todo.isDone ? "Completed" : "Incomplete", isOn: $todo.isDone)
                    Text("First item in second section")
                    Text("Second item in second section")
                } header: {
                    Text("Header")
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


#Preview {
    DetailTodoView(todo: ToDo(name: "Test Name", isDone: true, creationDate: Date(), targetDate: Date()))
}

