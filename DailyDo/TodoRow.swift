//
//  TodoRow.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI
import Foundation

struct TodoRow: View {
    
    let todo: ToDo
    
    var body: some View {
        
        let todayDate = Date()
        let targetDate = self.todo.targetDate
        
        let compareDates = todayDate.timeIntervalSince(targetDate)

        let minutesInterval = compareDates / 60
        let hoursInterval = minutesInterval / 60
        var daysInterval = hoursInterval / 24
        
        HStack {
            VStack(alignment: .leading) {
                Text(todo.name)
                    .font(.title3)
                    .bold()
                Text("\(todo.targetDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("Days until: \(targetDate.timeIntervalSinceNow.rounded())")
//                Text("Days: \(abs(daysInterval).rounded())")

            }

        }
    }

}


#Preview {
    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
}
