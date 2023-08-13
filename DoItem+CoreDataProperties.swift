//
//  DoItem+CoreDataProperties.swift
//  DailyDo
//
//  Created by Kristian Emil Hansen Svidt on 13/08/2023.
//
//

import Foundation
import CoreData


extension DoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DoItem> {
        return NSFetchRequest<DoItem>(entityName: "DoItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var note: String?
    @NSManaged public var date: Date?
    @NSManaged public var category: String?

}

extension DoItem : Identifiable {

}
