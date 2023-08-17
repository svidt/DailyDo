//
//  Tag.swift
//  DailyDo
//
//  Created by Svidt on 17/08/2023.
//

import Foundation
import SwiftData

@Model
final class Tag {
    var name: String
    
    var todos: [ToDo]?
    
    var color: RGBColor
    
    init(name: String, color: RGBColor) {
        self.name = name
        self.color = color
    }
}
