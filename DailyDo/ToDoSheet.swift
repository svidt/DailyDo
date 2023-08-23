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
    @State private var newPriority: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Section() {
                Text(newName == "" ? "DailyDo" : "\(newName)")
                    .font(.largeTitle)
                TextField("Add name", text: $newName)
                    .autocorrectionDisabled()
                TextField("Add priority", text: $newPriority)
            }
            Spacer()
        }
        .padding()
    }
    
}

#Preview {
    ToDoSheet()
}
