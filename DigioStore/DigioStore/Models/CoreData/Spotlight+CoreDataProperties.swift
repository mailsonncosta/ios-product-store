//
//  Spotlight+CoreDataProperties.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData

extension Spotlight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Spotlight> {
        return NSFetchRequest<Spotlight>(entityName: "Spotlight")
    }

    @NSManaged public var name: String?
    @NSManaged public var spotlightDescription: String?
    @NSManaged public var bannerURL: String?

}
