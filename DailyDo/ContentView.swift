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
    //    @Query(sort: \ToDo.creationDate, order: .reverse) private var todos: [ToDo]
    
    @Query(sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var todos: [ToDo]
    
    // Sort after creation date and filter for completed/incomplete ToDos
    @Query(filter: #Predicate<ToDo>{ $0.isDone }, sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var completedTodos: [ToDo]
    
    @Query(filter: #Predicate<ToDo>{ !$0.isDone }, sort: [.init(\ToDo.creationDate, order: .reverse)], animation: .smooth) private var incompleteTodos: [ToDo]
    
    var body: some View {
        NavigationSplitView {
            List {
                Section("DailyDos") {
                    ForEach(incompleteTodos) { todo in
                        NavigationLink {
                            DetailTodoView(todo: todo)
                        } label: {
                            TodoRow(todo: todo)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    
                }
                
                Section("All Done 👍") {
                    ForEach(completedTodos) { todo in
                        NavigationLink {
                            DetailTodoView(todo: todo)
                        } label: {
                            TodoRow(todo: todo)
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        let newItem = ToDo(name: "new name")
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
