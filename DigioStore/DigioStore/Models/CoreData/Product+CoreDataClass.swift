//
//  Product+CoreDataClass.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {
    
    enum CodingKeys: String, CodingKey {
        case name, imageURL, productDescription
    }

    required public convenience init(context: NSManagedObjectContext, dictionary: [String: Any]) throws {
        self.init(context: context)
        
        self.name = dictionary["name"] as? String
        self.imageURL = dictionary["imageURL"] as? String
        self.productDescription = dictionary["description"] as? String
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.imageURL = try values.decode(String.self, forKey: .imageURL)
        self.productDescription = try values.decode(String.self, forKey: .productDescription)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(imageURL, forKey: .imageURL)
        try container.encode(productDescription, forKey: .productDescription)
    }
    
}
