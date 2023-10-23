//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 16/08/2023.
//
//  Mainstructure, guided by Karin Prater
//  https://www.youtube.com/watch?v=CcUgRDLcUmQ
//
// SwipeActions: https://www.hackingwithswift.com/books/ios-swiftui/adding-custom-row-swipe-actions-to-a-list
// Notifications: https://www.hackingwithswift.com/books/ios-swiftui/scheduling-local-notifications
// Adding QR Code: https://www.hackingwithswift.com/books/ios-swiftui/generating-and-scaling-up-a-qr-code
// Working with Dates: https://www.hackingwithswift.com/books/ios-swiftui/working-with-dates

import SwiftUI
import SwiftData
import UserNotifications

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Order ToDo's in reverse date order - Newest one on top, oldest at the bottom.
    @Query(sort: [.init(\ToDo.targetDate, order: .reverse)], animation: .smooth) private var todos: [ToDo]
    
    // Sort after creation date and filter for completed ToDos
    @Query(filter: #Predicate<ToDo>{ $0.isDone }, sort: [.init(\ToDo.targetDate, order: .reverse)], animation: .smooth) private var completedTodos: [ToDo]
    
    // Sort after creation date and filter for incomplete ToDos
    @Query(filter: #Predicate<ToDo>{ !$0.isDone }, sort: [.init(\ToDo.targetDate, order: .reverse)], animation: .smooth) private var incompleteTodos: [ToDo]
    
    @State private var showingToDoSheet = false
    @State private var hideButtonWhenNotOnPage = false
    
    var body: some View {
        
        let gradient = LinearGradient(
            colors: [.purple, .blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        ZStack {
            NavigationView {
                List {
                    Section("Coming up") {
                        ForEach(incompleteTodos) { todo in
                            if todo.targetDate >= Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                        .onAppear {
                                            withAnimation {
                                                hideButtonWhenNotOnPage = true
                                            }
                                        }
                                        .onDisappear {
                                            withAnimation {
                                                hideButtonWhenNotOnPage = false
                                            }
                                        }
                                } label: {
                                    TodoRow(todo: todo)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        todo.isDone.toggle()
                                        print("\(todo.name) completed at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    } label: {
                                        Label("Completed", systemImage: "checkmark.circle")
                                    }
                                    .tint(.green)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    // If DONE and is still in future
                    Section("Done Do's") {
                        ForEach(completedTodos) { todo in
                            if todo.targetDate > Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                } label: {
                                    TodoRow(todo: todo)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    // If is in the past
                    Section("History") {
                        ForEach(todos) { todo in
                            if todo.targetDate < Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                } label: {
                                    TodoRow(todo: todo)
                                }
                            }
                        }
                    }
                }
                
                .navigationTitle("DailyDo")
                .sheet(isPresented: $showingToDoSheet)
                {
                    ToDoSheet(todo: ToDo(name: "Test", creationDate: Date(), targetDate: Date()), isPresented: $showingToDoSheet)
                        .presentationDetents([.fraction(0.7)])
                }
                
            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        showingToDoSheet = true
                        
                        // Adding test ToDos
                        let todo_future = ToDo(name: "Future", isDone: false, creationDate: .now, targetDate: .distantFuture)
                        let todo_past = ToDo(name: "Past", isDone: false, creationDate: .now, targetDate: .distantPast)
                        let todo_now = ToDo(name: "Now", isDone: false, creationDate: .now, targetDate: .now)
                        
                        modelContext.insert(todo_future)
                        modelContext.insert(todo_past)
                        modelContext.insert(todo_now)
                        
                        
                    } label: {
                        Image(systemName: "plus")
                            .bold()
                            .padding(20)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        
                    }
                    .background(gradient)
                    .clipShape(Circle())
                    .padding()
                    .offset(CGSize(width: hideButtonWhenNotOnPage == false ? 0.0 : 100.0, height: 0))
                }
                Spacer()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
            print("Item deleted")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: ToDo.self, inMemory: true)
}
