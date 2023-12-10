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
// Searchable text: https://www.hackingwithswift.com/books/ios-swiftui/making-a-swiftui-view-searchable


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
    
    @State private var searchText = ""
    
    var body: some View {
        
        // Global gradient colorscheme
        let gradient = LinearGradient(
            colors: [.purple, .blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        ZStack {
            NavigationView {
                List {
                    Section("☑️ Do") {
                        ForEach(incompleteTodos) { todo in
                            if todo.targetDate >= Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                } label: {
                                    TodoRow(todo: todo)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        todo.isDone.toggle()
                                        print("\(todo.name) Done at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    } label: {
                                        Label("Done", systemImage: "checkmark.circle")
                                    }
                                    .tint(.green)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    // If DONE and is still in future
                    Section("✅ Done") {
                        ForEach(completedTodos) { todo in
                            if todo.targetDate > Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                } label: {
                                    TodoRow(todo: todo)
                                }
                                .swipeActions(edge: .leading) {
                                    Button {
                                        todo.isDone.toggle()
                                        print("\(todo.name) Undo at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    } label: {
                                        Label("Undo", systemImage: "arrow.uturn.backward")
                                    }
                                    .tint(.yellow)
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    
                    // If is in the past
                    Section("📋 Did") {
                        ForEach(todos) { todo in
                            if todo.targetDate < Date.now {
                                NavigationLink {
                                    DetailTodoView(todo: todo)
                                } label: {
                                    TodoRow(todo: todo)
                                }
                                
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                .searchable(text: $searchText, prompt: "Search")
                .navigationTitle("DailyDo")
                .sheet(isPresented: $showingToDoSheet)
                {
                    ToDoSheet(todo: ToDo(name: "Test", creationDate: Date(), targetDate: Date()), isPresented: $showingToDoSheet)
                }
                .toolbar {
                    Button(action: {
                        showingToDoSheet = true
                        
                        // Adding test ToDos
                        let todo_future = ToDo(name: "Future", isDone: false, creationDate: .now, targetDate: .distantFuture)
                        let todo_past = ToDo(name: "Past", isDone: false, creationDate: .now, targetDate: .distantPast)
                        let todo_now = ToDo(name: "Now", isDone: false, creationDate: .now, targetDate: .now)
                        
                        modelContext.insert(todo_future)
                        modelContext.insert(todo_past)
                        modelContext.insert(todo_now)
                        
                    }, label: {
                        Image(systemName: "plus")
                            .bold()
                            .imageScale(.large)
                            .padding(20)
                            .foregroundColor(.white)
                            .background(gradient)
                            .clipShape(Circle())
                    })
                }
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
