//
//  DailyDoItem.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 30/07/2023.
//

import Foundation
import SwiftData

@Model
class DailyDoItem: Identifiable {
    var id: String
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
    
}
