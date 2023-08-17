//
//  TodoRow.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 17/08/2023.
//

import SwiftUI

struct TodoRow: View {
    
    let todo: ToDo
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(todo.name)
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(todo.isDone ? .green : .gray)
            }
            Text(todo.creationDate, format: Date.FormatStyle(date: .numeric, time: .standard))
        }
    }
}

/*
#Preview {
    TodoRow()
}
*/
