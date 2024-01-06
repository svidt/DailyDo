////
////  TestButtonView.swift
////  DailyDo
////
////  Created by Kristian Emil on 05/01/2024.
////
//
//import SwiftUI
//
//struct TestButtonView: View {
//    
//    @Environment(\.modelContext) private var modelContext
//    
//    var body: some View {
//        Button(action: {
//            // Adding test ToDos
//            let todo_future = ToDo(name: "Future", targetDate: false, notificationDate: .distantFuture, isDone: true)
//            let todo_past = ToDo(name: "Past", targetDate: false, notificationDate: .distantPast, isDone: true)
//            let todo_now = ToDo(name: "Now", targetDate: false, notificationDate: .now, isDone: true)
//            
//            modelContext.insert(todo_future)
//            modelContext.insert(todo_past)
//            modelContext.insert(todo_now)
//            
//        }, label: {
//            Image(systemName: "plus")
//                .bold()
//                .imageScale(.large)
//                .padding(20)
//                .foregroundColor(.white)
//                .clipShape(Circle())
//        })
//    }
//}
//
//#Preview {
//    TestButtonView()
//}
