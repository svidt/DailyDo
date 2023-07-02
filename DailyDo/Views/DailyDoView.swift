//
//  ContentView.swift
//  DailyDo
//
//  Created by Svidt on 02/07/2023.
//

import SwiftUI
import CoreData

struct DailyDoView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DoItem.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<DoItem>
    
    var body: some View {
        
        NavigationView {
            
            VStack {
            
                ZStack {
                
                    List {
                    
                        ForEach(items) { item in
                            NavigationLink(destination: DoEditView(passedDoItem: item, initialDate: Date())
                                .environmentObject(dateHolder))
                            {
                                Text(item.timestamp!, formatter: itemFormatter)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    }
                    
                    FloatingButton().environmentObject(dateHolder)
                }
            }
            .navigationTitle("DailyDo")
            
        }
    }
    
    
    func saveContext(_ context: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            dateHolder.saveContext(viewContext)
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DailyDoView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
