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
    
    @State private var todayDate = Date()
    @State private var newName: String = ""
    @State private var creationDate: Date = Date()
    @State private var targetDate: Date = Date()
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Section() {
                var placeholderText: String {
                    newName == "" ? "DailyDo" : newName
                }
                Text(placeholderText)
                    .font(.largeTitle).bold()
                    .foregroundStyle(.purple)
                HStack {
                    TextField("Add name", text: $newName)
                        .padding(10)
                        .background(.purple.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .autocorrectionDisabled()
                    Button("+ Add") {
                        addItem()
                        print("\(todo.name) added")
                    }
                    .disabled(newName == "" ? true : false)
                    .bold()
                    .padding(10)
                    .background(.purple)
                    .foregroundColor(.white)
                    .opacity(newName == "" ? 0.5 : 1.0)
                    .clipShape(Capsule())
                }
            }
            
            Section {
                DatePicker("Pick at date please", selection: $targetDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(.purple)
            }
            
//            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
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
