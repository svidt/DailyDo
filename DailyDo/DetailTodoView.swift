//
//  DetailTodoView.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import SwiftUI

struct DetailTodoView: View {
    
    @Bindable var todo: ToDo
    @State private var textToEdit = false
    @State private var isCalendarShowing = false
    
    var body: some View {
        
        VStack {
            VStack {
                
//                TextField("Change Name", text: $todo.name)
//                    .textFieldStyle(.roundedBorder)
                HStack {
                    DatePicker("Change date", selection: $todo.targetDate)
                        .datePickerStyle(.compact)
                    Button {
                        todo.notificationDate.toggle()
                    } label: {
                        Image(systemName: todo.notificationDate ? "bell.fill" : "bell.slash.fill") }
                        .bold()
                        .imageScale(.large)
                        .foregroundColor(.dailydoPrimary.opacity(todo.notificationDate ? 1.0 : 0.8))
                        .padding(.horizontal, 10)
                    
                }
            }

            // Display Image
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
//    DetailTodoView(todo: ToDo(name: "Preview Name", isDone: true, creationDate: .now, targetDate: .distantFuture))
//}

