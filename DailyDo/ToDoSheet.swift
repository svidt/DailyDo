//
//  ToDoSheet.swift
//  DailyDo
//
//  Created by Svidt on 21/08/2023.
//

import SwiftUI
import SwiftData

struct ToDoSheet: View {
    
    @Environment(\.modelContext)  var modelContext
    
    @Bindable var todo: ToDo
    @Binding var isPresented: Bool
    
    @FocusState var keyboardFocused: Bool
    
    @State var todayDate = Date()
    @State var newName: String = ""
    @State var targetDate: Date = Date()
    
    @State var isPickerShowing = false
    @State var notify: Bool
    
    var body: some View {
        
        // Copy this global gradient
        let colorGradient = LinearGradient(
            colors: [.dailydoPrimary, .dailydoSecondary],
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
                    .background(.dailydoPrimary.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    .autocorrectionDisabled()
                    .focused($keyboardFocused)
                    .onAppear {
                        keyboardFocused = true
                    }
                    .overlay(alignment: .trailing) {
                        Button {
                            todo.notify.toggle()
                        } label: { Image(systemName: todo.notify ? "bell.fill" : "bell.slash.fill") }
                            .contentTransition(.symbolEffect(.replace))
                            .imageScale(.large)
                            .foregroundColor(.dailydoPrimary.opacity(todo.notify ? 1.0 : 0.5))
                            .padding(.horizontal, 10)
                    }
                
                Button {
                    isPickerShowing = true
                    print("Opening camera..")
                } label: { Image(systemName: "camera.fill") }
                    .imageScale(.large)
                    .padding(10)
                    .background(colorGradient)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                        ImagePicker(todo: todo)
                    }
                
                Button {
                    addItem()
                    print("\(todo.name) added")
                } label: { Image(systemName: "checkmark") }
                    .bold()
                    .imageScale(.large)
                    .padding(10)
                    .background(colorGradient)
                    .foregroundColor(.white)
                    .opacity(newName == "" ? 0.5 : 1.0)
                    .disabled(newName == "" ? true : false)
                    .clipShape(Circle())
                
            }
            
            DatePicker("Select a date", selection: $targetDate)
                .datePickerStyle(.compact)
                .tint(.dailydoSecondary)
                .padding(.vertical)
        }
    }
    
    
    func addItem() {
        let newItem = ToDo(name: newName, targetDate: targetDate, notify: todo.notify, isDone: false)
        modelContext.insert(newItem)
        isPresented = false
    }
}

//#Preview {
//    ToDoSheet()
//}
