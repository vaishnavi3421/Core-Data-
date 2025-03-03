//
//  ToDoListItems+CoreDataProperties.swift
//  Core Data TO DO List
//
//  Created by Vaishnavi Wahgule on 19/02/25.
//
//

import Foundation
import CoreData


extension ToDoListItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItems> {
        return NSFetchRequest<ToDoListItems>(entityName: "ToDoListItems")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension ToDoListItems : Identifiable {

}
