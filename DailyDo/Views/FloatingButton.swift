//
//  FloatingButton.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 02/07/2023.
//

import SwiftUI

struct FloatingButton: View {
    var body: some View {
        Spacer()
        HStack {
            NavigationLink {
                DoEditView()
            } label: {
                Text("+ Add Do")
                    .font(.headline)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.accentColor)

        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
