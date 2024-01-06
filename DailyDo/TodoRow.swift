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
                    .font(.headline)
                HStack {
                    Text("\(todo.targetDate.formatted(date: .abbreviated, time: .omitted))")
                    Text("\(todo.targetDate.formatted(date: .omitted, time: .shortened))")
                    Image(systemName: todo.notify ? "bell.fill" : "bell.slash.fill")
                        .foregroundColor(.dailydoPrimary.opacity(todo.notify ? 1.0 : 0.5))
                }
                .font(.subheadline)
            }
            Spacer()
            VStack {
                if todo.isDone {
                    Image(systemName: "checkmark")
                        .imageScale(.large)
                } else {
                    Text(displayDays)
                        .font(.headline)
                }
            }
        }
    }
}


//#Preview {
//    TodoRow(todo: ToDo(name: "Placeholder", targetDate: .now, notificationDate: true, isDone: false))
//}
