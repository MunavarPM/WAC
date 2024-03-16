//
//  ProductEntity+CoreDataProperties.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?

}

extension ProductEntity : Identifiable {

}
