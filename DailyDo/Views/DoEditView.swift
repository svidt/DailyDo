//
//  DoEditView.swift
//  DailyDo
//
//  Created by Svidt on 02/07/2023.
//

import SwiftUI

struct DoEditView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var dateHolder: DateHolder
    
    @State var selectedDoItem: DoItem?
    @State var name: String
    @State var note: String
    @State var dueDate: Date
    @State var timeSchedule: Bool
    
    init(passedDoItem: DoItem?, initialDate: Date)
    {
        if let DoItem = passedDoItem
        {
            _selectedDoItem = State(initialValue: DoItem)
            _name = State(initialValue: DoItem.name ?? "")
            _note = State(initialValue: DoItem.note ?? "")
            _dueDate = State(initialValue: DoItem.dueDate ?? initialDate)
            _timeSchedule = State(initialValue: DoItem.timeSchedule)
        }
        else
        {
            _name = State(initialValue: "")
            _note = State(initialValue: "")
            _dueDate = State(initialValue: initialDate)
            _timeSchedule = State(initialValue: false)
        }
    }
    
    var body: some View {
        
        Form {
            
            Section(header: Text("Do's")) {
                
                TextField("Name", text: $name)
                TextField("Note", text: $note)
            }
            
            Section(header: Text("Due Date")) {
                
                Toggle("Time Schedule", isOn: $timeSchedule)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: displayComps())
            }
            
            Section() {
                Button("Save", action: saveAction)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            
        }
    }
    
    func displayComps() -> DatePickerComponents
    {
        return timeSchedule ? [.hourAndMinute, .date] : [.date]
    }
    
    func saveAction()
    {
        withAnimation
        {
            if selectedDoItem == nil
            {
                selectedDoItem = DoItem(context: viewContext)
            }
            
            selectedDoItem?.timestamp = Date()
            selectedDoItem?.name = name
            selectedDoItem?.dueDate = dueDate
            selectedDoItem?.timeSchedule = timeSchedule
            
            dateHolder.saveContext(viewContext)
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
}

struct DoEditView_Previews: PreviewProvider {
    static var previews: some View {
        DoEditView(passedDoItem: DoItem(), initialDate: Date())
    }
}
