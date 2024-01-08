//
//  DetailTodoView.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI
import SwiftData

struct DetailTodoView: View {
    
    @Bindable var todo: ToDo
//    @State private var textToEdit = false
//    @State private var isCalendarShowing = false
    
    var body: some View {
        
        VStack {
            VStack {
                
//                TextField("Change Name", text: $todo.name)
//                    .textFieldStyle(.roundedBorder)
                HStack {
                    DatePicker("Change date", selection: $todo.targetDate)
                        .datePickerStyle(.compact)
                    Button {
                        todo.notify.toggle()
                    } label: {
                        Image(systemName: todo.notify ? "bell.fill" : "bell.slash.fill") }
                        .contentTransition(.symbolEffect(.replace))
                        .imageScale(.large)
                        .foregroundColor(.dailydoPrimary.opacity(todo.notify ? 1.0 : 0.5))
                        .padding(.horizontal, 10)
                }
            }

            Image("plant")
                .resizable()
                .cornerRadius(10)
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("\(todo.name)")
        .padding()
    }
}


//#Preview {
//    DetailTodoView(todo: ToDo(name: "Placeholder", targetDate: Date.now, notify: false, isDone: false))
//}

