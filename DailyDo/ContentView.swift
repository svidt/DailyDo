//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 30/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: DoItem.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \DoItem.name, ascending: true)])
    
    var dailyDos: FetchedResults<DoItem>
    
    @State private var showingDoSheet = false
    
    var body: some View {

        NavigationView {
            
            List {
                ForEach(dailyDos, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text(item.name ?? "No name")
                            .font(.title)
                        Text(item.note ?? "No description")
                            .font(.subheadline)
                        Text(item.category ?? "Default")
                    }
                }
                .onDelete(perform: deleteDo(at:))
                if dailyDos.count == 0 {
                    Text("No Do's Found")
                }
            }
            .navigationTitle("DailyDo's")
            .navigationBarItems(leading: EditButton(), trailing: Button("Add") {
                self.showingDoSheet.toggle()
            })
            .sheet(isPresented: $showingDoSheet) {
                DoSheet().environment(\.managedObjectContext, self.moc)
            }
        }
        
    }
    
    func deleteDo(at offsets: IndexSet) {
        for index in offsets {
            let dos = dailyDos[index]
            moc.delete(dos)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
