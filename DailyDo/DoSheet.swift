//
//  DoSheet.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 13/08/2023.
//

import SwiftUI

struct DoSheet: View {
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    @State private var note = ""
    @State private var category = "Personal"
    @State private var addPhoto = false
    
    private let categories = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter name", text: $name)
                        .disableAutocorrection(true)
                    TextField("Enter description", text: $note)
                        .disableAutocorrection(true)
                    Picker("Select category", selection: $category) {
                        ForEach(categories, id: \.self) { cate in
                            Text(cate)
                        }
                    }
                    
                }
                Section {
                    Toggle(isOn: $addPhoto) {
                        Text("Add Photo")
                    }
                }
            }
            .navigationBarTitle(Text("Add DailyDo"))
            .toolbar {
                Button("Add") {
                    let doItem = DoItem(context: self.moc)
                    doItem.name = self.name
                    doItem.note = self.note
                    doItem.category = self.category
                    do {
                        try self.moc.save()
                    } catch {
     i                   print("Something went wrong \(error.localizedDescription)")
                    }
                }
            }
        }

    }
}

struct DoSheet_Previews: PreviewProvider {
    static var previews: some View {
        DoSheet()
    }
}
