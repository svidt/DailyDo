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
        
        let dayCount = Int(timeInterval.rounded(.up))
            
        // If DailyDo is in the future
        if todo.targetDate > Date.now {
            HStack {
                VStack(alignment: .leading) {
                    Text(todo.name)
                        .font(.title3)
                        .bold()
                    Text("\(todo.targetDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    if dayCount == abs(1) {
                        Text("\(Int(timeInterval.rounded(.up))) Day")
                            .font(.title3)
                            .bold()
                    } else {
                        Text("\(Int(timeInterval.rounded(.up))) Days")
                            .font(.title3)
                            .bold()

                    }
                }
            }
            
            // If DailyDo is in the past
        } else {
            
            HStack {
                VStack(alignment: .leading) {
                    Text(todo.name)
                        .font(.subheadline)
                        .bold()
                    Text("\(todo.targetDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.subheadline)
                }
                
                Spacer()
                
                VStack {
                    Text("\(Int(timeInterval.rounded())) Day")
                        .font(.subheadline)
                }
            }
            .foregroundColor(.gray)
        }
    }
}


#Preview {
    TodoRow(todo: ToDo(name: "Title Name", creationDate: Date(), targetDate: Date()))
}
