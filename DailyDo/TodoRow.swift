//
//  TodoRow.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI

struct TodoRow: View {
    
    let todo: ToDo
    
//    let timeDifference = todo.targetDate.formatted(date: .numeric, time: .omitted)
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(todo.name)
                    .font(.title3)
                    .bold()
                Text(todo.targetDate, format: Date.FormatStyle(date: .numeric))
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("\(Date().distance(to: todo.targetDate).formatted())")
                Text("\(todo.targetDate.distance(to: Date()))")

            }

        }
    }
    
//    func daysTo(date: Date) -> Int? {
//        let calender = Calender.current
//    }
}


//#Preview {
//    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
//}
