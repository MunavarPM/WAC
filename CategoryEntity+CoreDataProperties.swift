//
//  CategoryEntity+CoreDataProperties.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}

extension CategoryEntity : Identifiable {

}
