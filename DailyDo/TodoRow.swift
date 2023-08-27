//
//  TodoRow.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI

struct TodoRow: View {
    
    let todo: ToDo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.name)
                    .font(.title3)
                    .bold()
                Text(todo.targetDate, format: Date.FormatStyle(date: .numeric))
                    .font(.subheadline)
            }
//            VStack {
//                Text(todo.isDone == true ? "Completed" : "Incomplete")
//                    .font(.title3)
//                    .bold()
//                Text(todo.creationDate, format: Date.FormatStyle(date: .numeric))
//                    .font(.subheadline)
//            }

        }
    }
}


//#Preview {
//    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
//}
