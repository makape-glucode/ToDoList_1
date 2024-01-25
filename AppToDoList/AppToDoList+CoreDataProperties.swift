//
//  AppToDoList+CoreDataProperties.swift
//  AppToDoList
//
//  Created by Makape Tema on 2023/03/14.
//
//

import Foundation
import CoreData


extension AppToDoList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppToDoList> {
        return NSFetchRequest<AppToDoList>(entityName: "AppToDoList")
    }

    @NSManaged public var id: NSNumber
    @NSManaged public var name: String?
    @NSManaged public var taskDescription: String?
    @NSManaged public var createdDate: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var isComplete: Bool
    @NSManaged public var category: Int
    @NSManaged public var delete: Bool
    

}

extension AppToDoList : Identifiable {

}
