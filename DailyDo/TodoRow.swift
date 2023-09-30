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
                Text(String(todo.targetDate.formatted(date: .numeric, time: .omitted)))
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text("\(Date().formatted(date: .numeric, time: .omitted))")
//                Text("Seconds: \(compareDates)")
//                Text("Minutes: \(minutesInterval)")
//                Text("Hours: \(hoursInterval)")
                Text("Days: \(abs(daysInterval).rounded())")

            }

        }
    }

}


#Preview {
    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
}
