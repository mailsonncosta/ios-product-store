//
//  Product+CoreDataProperties.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var productDescription: String?

}
