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
                Text(String(todo.targetDate.distance(to: Date.now)))
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("\(Date().distance(to: todo.targetDate).formatted())")
                Text("\(todo.targetDate.distance(to: Date()))")

            }

        }
    }

}


//#Preview {
//    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
//}
