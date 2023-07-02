//
//  FloatingButton.swift
//  DailyDo
//
//  Created by Svidt on 02/07/2023.
//

import SwiftUI

struct FloatingButton: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    
    var body: some View {
        
        Spacer()
        
        HStack {
            NavigationLink {
                DoEditView(passedDoItem: nil, initialDate: Date())
                    .environmentObject(dateHolder)
            } label: {
                Text("+ Add Do")
                    .font(.headline)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(30)
            .padding()
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)

        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
