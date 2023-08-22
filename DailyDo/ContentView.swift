//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 16/08/2023.
//
//  Guided by Karin Prater
//  https://www.youtube.com/watch?v=CcUgRDLcUmQ

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    // Order ToDo's in reverse date order - Newest one on top, oldest at the bottom.
    @Query(sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var todos: [ToDo]
    
    // Sort after creation date and filter for completed ToDos
    @Query(filter: #Predicate<ToDo>{ $0.isDone }, sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var completedTodos: [ToDo]
    
    // Sort after creation date and filter for incomplete ToDos
    @Query(filter: #Predicate<ToDo>{ !$0.isDone }, sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var incompleteTodos: [ToDo]
    
    @State private var showingToDoSheet = false
    @State private var newName = "Newly added"
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("💪 Coming up") {
                    ForEach(incompleteTodos) { todo in
                        NavigationLink {
                            DetailTodoView(todo: todo)
                        } label: {
                            TodoRow(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                    
                }
                
                Section("👍 All Done") {
                    ForEach(completedTodos) { todo in
                        NavigationLink {
                            DetailTodoView(todo: todo)
                        } label: {
                            TodoRow(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("DailyDo")
            .sheet(isPresented: $showingToDoSheet) {
                ToDoSheet()
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingToDoSheet = true
                        addItem()
                    } label: {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(5)
                    .background(.yellow)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                }
                
            }
            
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        let newItem = ToDo(name: newName)
        modelContext.insert(newItem)
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(todos[index])
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: ToDo.self, inMemory: true)
}
