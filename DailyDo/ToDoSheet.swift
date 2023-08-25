//
//  ToDoSheet.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 21/08/2023.
//

import SwiftUI
import SwiftData

struct ToDoSheet: View {
    
    @Environment(\.modelContext) private var modelContext
    
//    @Bindable var todo: ToDo
    
    @State private var newName: String = ""
    @State private var dateCreated: Date = Date()
    @State private var targetDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Section() {
                var placeholderText: String {
                    newName == "" ? "DailyDo" : newName
                }
                Text(placeholderText)
//                Text(newName == "" ? "" : "\(newName)")
                    .font(.largeTitle).bold()
                    .foregroundStyle(.purple)
                HStack {
                    TextField("Add name", text: $newName)
                        .padding(10)
                        .background(.purple.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .autocorrectionDisabled()
                    Button("+ Add") {
                        // Code
                    }
                    .bold()
                    .padding(10)
                    .background(.purple)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    
                    
                }
                
                
            }
            
            Section {
                DatePicker("Pick at date please", selection: $targetDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .tint(.purple)
            }
            //        footer: {
            //            Text("\(dateCreated.formatted(date: .abbreviated, time: .omitted))")
            //                .font(.subheadline)
            //                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            //        }
            
//            Spacer()
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 20)
    }
    
}

#Preview {
    ToDoSheet()
}
