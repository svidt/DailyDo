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
    
    @State private var isPickerShowing = false
//    @State private var isNotificationEnabled: Bool
    
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
                            todo.notificationDate.toggle()
                            
                        } label: { Image(systemName: todo.notificationDate ? "bell.fill" : "bell.slash.fill") }
                            .bold()
                            .imageScale(.large)
                            .foregroundColor(.dailydoPrimary.opacity(todo.notificationDate ? 1.0 : 0.5))
                            .padding(.horizontal, 10)
                    }
                
                Button {
                    isPickerShowing = true
                    print("Opening camera..")
                } label: { Image(systemName: "camera.fill") }
                    .bold()
                    .imageScale(.large)
                    .padding(10)
                    .background(colorGradient)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .sheet(isPresented: $isPickerShowing, onDismiss: nil) {
                        // Image picker
//                        ImagePicker()
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
                .datePickerStyle(.graphical)
                .tint(.dailydoSecondary)
            
        }
        .padding(10)
        Spacer()
    }
    
    
    func addItem() {
        let newItem = ToDo(name: newName, isDone: false, creationDate: creationDate, targetDate: targetDate, notificationDate: false)
        modelContext.insert(newItem)
        isPresented = false
    }
}

//#Preview {
//    ToDoSheet()
//}
