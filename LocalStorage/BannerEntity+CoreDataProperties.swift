//
//  BannerEntity+CoreDataProperties.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//
//

import Foundation
import CoreData


extension BannerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BannerEntity> {
        return NSFetchRequest<BannerEntity>(entityName: "BannerEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image_url: String?

}

extension BannerEntity : Identifiable {

}
