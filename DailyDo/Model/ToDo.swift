//
//  ToDo.swift
//  DailyDo
//
//  Created by Svidt on 16/08/2023.
//

import Foundation
import SwiftData

@Model
final class ToDo {
        
    @Attribute
    var name: String = "Name"
    var targetDate: Date = Date.now
    var notify: Bool = false
    var isDone: Bool = false
    var notificationIdentifier: String
    
    @Attribute(.externalStorage)
    var photo: Data?
    
    init(name: String, targetDate: Date, notify: Bool, isDone: Bool) {
        self.name = name
        self.targetDate = targetDate
        self.notify = notify
        self.isDone = isDone
        self.notificationIdentifier = UUID().uuidString
    }
}


