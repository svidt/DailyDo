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
    
    @State private var newName: String = "Add new name"
    
    var body: some View {
        VStack(alignment: .leading) {
            Section() {
                Text("Name")
                    .font(.title)
                TextField("Add Name here", text: $newName)
            }
            .padding()
            
            
            HStack(alignment: .center) {
                Spacer()
                
                Button("Add Do") {
                    // Code
                    
                }
                .padding(5)
                .background(.yellow)
                .foregroundColor(.black)
                .clipShape(Capsule())
                
                Spacer()
            }
        }
        .padding()
    }
    
}

#Preview {
    ToDoSheet()
}
