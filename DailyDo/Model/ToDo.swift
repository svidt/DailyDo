//
//  ToDo.swift
//  DailyDo
//
//  Created by Svidt on 16/08/2023.
//

import Foundation
import SwiftData
import UIKit

@Model
final class ToDo {
        
    @Attribute(.unique)
    var creationDate: Date
    var targetDate: Date
    var name: String
    var isDone: Bool
    var notificationDate: Bool
    
    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String, isDone: Bool = false, creationDate: Date, targetDate: Date, notificationDate: Bool) {
        self.creationDate = creationDate
        self.targetDate = targetDate
        self.name = name
        self.isDone = isDone
        self.notificationDate = notificationDate
    }
}


