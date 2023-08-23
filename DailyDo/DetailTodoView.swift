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
            
            Text(todo.name)
                .font(.largeTitle)
            TextField("New ToDo", text: $todo.name)
                .textFieldStyle(.roundedBorder)
            
            Toggle(todo.isDone ? "Done" : "Open", isOn: $todo.isDone)
            
            
            Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                .foregroundColor(todo.isDone ? .green : .gray)
        }
        .padding(5)
    }
}


//#Preview {
//    DetailTodoView()
//}

