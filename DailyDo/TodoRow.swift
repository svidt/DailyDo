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
        
        let targetDate = self.todo.targetDate
        let timeInterval = targetDate.timeIntervalSinceNow / 60 / 60 / 24
        
        let dayDays = Int(timeInterval.rounded())
        
        var displayDays: String  {
            if dayDays >= 2 {
                String("\(dayDays) Days")
            } else if dayDays == 1 {
                String("\(dayDays) Day")
            } else if dayDays == 0 {
                String("Today")
            } else if dayDays == -1 {
                String("\(dayDays) Day ago")
            } else if dayDays <= -2 {
                String("\(dayDays) Days ago")
            }
            else {
                String("Missing date")
            }
        }
        HStack {
            VStack(alignment: .leading) {
                Text(todo.name)
                Text("\(todo.targetDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.subheadline)
            }
            Spacer()
            VStack {
                Text(displayDays)
            }
        }
    }
}


#Preview {
    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date(), notificationDate: false))
}
