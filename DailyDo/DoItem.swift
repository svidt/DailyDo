//
//  DailyDoItem.swift
//  DailyDo
//
//  Created by Svidt on 30/07/2023.
//

import SwiftData

@Model
class DoItem {
    @Attribute(.unique) var name: String
    var note: String
    
    init(name: String, note: String) {
        self.name = name
        self.note = note
    }
    
}
