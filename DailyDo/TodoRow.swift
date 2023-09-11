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
                Text(String(todo.targetDate.formatted(date: .numeric, time: .omitted)))
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("\(Date().formatted(date: .numeric, time: .omitted))")
                Text("\(todo.targetDate.compare(Date())")

            }

        }
    }

}


//#Preview {
//    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
//}
