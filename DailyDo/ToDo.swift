//
//  Item.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 16/08/2023.
//

import Foundation
import SwiftData

@Model
final class ToDo {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
