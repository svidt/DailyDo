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
    
    @State private var showingToDoSheet = false
    @State private var searchText = ""
    @State private var tapped = false
    
    // Global gradient colorscheme
    let gradient = LinearGradient(
        colors: [.dailydoPrimary, .dailydoSecondary],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    if searchText.isEmpty {
                        ForEach(todos) { todo in
                            NavigationLink {
                                DetailTodoView(todo: todo)
                            } label: {
                                TodoRow(todo: todo)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    todo.isDone.toggle()
                                    if todo.isDone {
                                        print("\(todo.name) done at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    } else {
                                        print("\(todo.name) undone at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    }
                                } label: {
                                    if todo.isDone {
                                        Label("Undo", systemImage: "arrow.uturn.backward")
                                    } else {
                                        Label("Done", systemImage: "checkmark")
                                    }
                                }
                                .tint(todo.isDone ? .yellow : .green)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    else {
                        ForEach(filteredTodos) { todo in
                            NavigationLink {
                                DetailTodoView(todo: todo)
                            } label: {
                                TodoRow(todo: todo)
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    todo.isDone.toggle()
                                    if todo.isDone {
                                        print("\(todo.name) done at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    } else {
                                        print("\(todo.name) undone at \(Date().formatted(date: .abbreviated, time: .shortened))")
                                    }
                                } label: {
                                    if todo.isDone {
                                        Label("Undo", systemImage: "arrow.uturn.backward")
                                    } else {
                                        Label("Done", systemImage: "checkmark.circle")
                                    }
                                }
                                .tint(todo.isDone ? .yellow : .green)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                }
                .navigationTitle("DailyDo")
                .searchable(text: $searchText, prompt: "Search")
                .sheet(isPresented: $showingToDoSheet)
                {
                    ToDoSheet(todo: ToDo(name: "", targetDate: Date(), notify: false, isDone: false), isPresented: $showingToDoSheet, notify: false)
                        .presentationDragIndicator(.visible)
                        .padding()
                    Spacer()
                }
                .onAppear {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success == true {
                            print("is all set for notifications 👍")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            showingToDoSheet = true
                        }, label: {
                            Image(systemName: "plus")
                                .bold()
                                .padding(10)
                                .foregroundColor(.white)
                                .background(gradient)
                                .clipShape(Circle())
                                
                        })
                    }
                }
            }
            .overlay {
                if todos.isEmpty {
                    VStack(spacing: 10) {
                        Image(systemName: tapped ? "heart.fill" : "heart")
                            .contentTransition(.symbolEffect(.replace))
                            .scaleEffect(2.0)
                            .opacity(0.4)
                            .onTapGesture {
                                tapped.toggle()
                            }
                        Text("A great day to add your first DailyDo")
                            .padding()
                            .opacity(0.4)
                    }
                }
            }
        }
        
    }
    
    var filteredTodos: [ToDo] {
        if searchText.isEmpty {
            return todos
        } else {
            return todos.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
