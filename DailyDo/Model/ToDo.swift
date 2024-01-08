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
        
    @Attribute/*(.unique)*/
    var name: String = "Name"
    var targetDate: Date = Date.now
    var notify: Bool = false
    var isDone: Bool = false
    
    @Attribute(.externalStorage)
    var image: Data?
    
    init(name: String, targetDate: Date, notify: Bool, isDone: Bool, image: Data? = nil) {
        self.name = name
        self.targetDate = targetDate
        self.notify = notify
        self.isDone = isDone
        self.image = image
    }
}


