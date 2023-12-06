//
//  ToDoSheet.swift
//  DailyDo
//
//  Created by Svidt on 21/08/2023.
//

import SwiftUI
import SwiftData

struct ToDoSheet: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Bindable var todo: ToDo
    @Binding var isPresented: Bool
    
    @FocusState private var keyboardFocused: Bool
    
    @State private var todayDate = Date()
    @State private var newName: String = ""
    @State private var creationDate: Date = Date()
    @State private var targetDate: Date = Date()
    
    var body: some View {
        
        // Copy this global gradient
        let colorGradient = LinearGradient(
            colors: [.purple, .blue],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        
        VStack(alignment: .leading) {
            var placeholderText: String {
                newName == "" ? "New event" : newName
            }
            Text(placeholderText)
                .font(.largeTitle)
                .bold()
            HStack {
                TextField("Add name", text: $newName)
                    .padding(10)
                    .bold()
                    .background(.purple.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .autocorrectionDisabled()
                    .focused($keyboardFocused)
                    .onAppear {
                        keyboardFocused = true
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            print("Adding image..")
                        } label: { Image(systemName: "plus") }
                            .bold()
                            .imageScale(.large)
                            .foregroundColor(.purple)
                            .padding(.horizontal, 10)
                    }
                
                Button {
                    addItem()
                    print("\(todo.name) added")
                } label: { Image(systemName: "checkmark") }
                    .bold()
                    .imageScale(.large)
                    .disabled(newName == "" ? true : false)
                    .padding(10)
                    .background(colorGradient)
                    .foregroundColor(.white)
                    .opacity(newName == "" ? 0.5 : 1.0)
                    .clipShape(Capsule())
            }
            DatePicker("Pick at date please", selection: $targetDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .tint(.purple)
        }
        .padding(10)
        Spacer()
    }
    
    
    func addItem() {
        let newItem = ToDo(name: newName, isDone: false, creationDate: creationDate, targetDate: targetDate)
        modelContext.insert(newItem)
        isPresented = false
    }
}

//#Preview {
//    ToDoSheet()
//}
