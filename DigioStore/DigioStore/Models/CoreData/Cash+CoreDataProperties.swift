//
//  Cash+CoreDataProperties.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData

extension Cash {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cash> {
        return NSFetchRequest<Cash>(entityName: "Cash")
    }

    @NSManaged public var bannerURL: String?
    @NSManaged public var cashDescription: String?
    @NSManaged public var title: String?

}
