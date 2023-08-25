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
        HStack {
            VStack(alignment: .leading) {
                Text(todo.name)
                    .font(.title3)
                    .bold()
                Text(todo.creationDate, format: Date.FormatStyle(date: .numeric))
                    .font(.subheadline)
                    
            }

        }
    }
}

/*
#Preview {
    TodoRow()
}
*/
