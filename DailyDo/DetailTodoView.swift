//
//  DetailTodoView.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import PhotosUI
import SwiftData
import SwiftUI

struct DetailTodoView: View {
    
    @Bindable var todo: ToDo
    @State private var photoPicker: PhotosPickerItem?

    var body: some View {
        
        VStack {
            VStack {
                
//                TextField("Change Name", text: $todo.name)
//                    .textFieldStyle(.roundedBorder)
                
                Section {
                    if let imageData = todo.photo, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    }
                    
                    PhotosPicker(selection: $photoPicker, matching: .images) {
                        Label("Select a photo", systemImage: "person")
                    }
                }
                
                HStack {
                    DatePicker("Change date", selection: $todo.targetDate)
                        .datePickerStyle(.compact)
                    Button {
                        todo.notify.toggle()
                    } label: {
                        Image(systemName: todo.notify ? "bell.fill" : "bell.slash.fill") }
                        .contentTransition(.symbolEffect(.replace))
                        .imageScale(.large)
                        .foregroundColor(.dailydoPrimary.opacity(todo.notify ? 1.0 : 0.5))
                        .padding(.horizontal, 10)
                }
            }
        }
        .onAppear {
            loadPhoto()
        }
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle("\(todo.name)")
        .onChange(of: photoPicker, loadPhoto)
        .padding()
    }
    
    func loadPhoto() {
        Task { @MainActor in
            todo.photo = try await photoPicker?.loadTransferable(type: Data.self)
        }
    }
}


//#Preview {
//    DetailTodoView(todo: ToDo(name: "Placeholder", targetDate: Date.now, notify: false, isDone: false))
//}

