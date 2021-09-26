//
//  Cash+CoreDataClass.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData

@objc(Cash)
public class Cash: NSManagedObject {
    
    enum CodingKeys: String, CodingKey {
        case title, bannerURL, cashDescription
    }

    required public convenience init(context: NSManagedObjectContext, dictionary: [String: Any]) throws {
        self.init(context: context)
        
        self.title = dictionary["title"] as? String
        self.bannerURL = dictionary["bannerURL"] as? String
        self.cashDescription = dictionary["description"] as? String
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.bannerURL = try values.decode(String.self, forKey: .bannerURL)
        self.cashDescription = try values.decode(String.self, forKey: .cashDescription)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(bannerURL, forKey: .bannerURL)
        try container.encode(cashDescription, forKey: .cashDescription)
    }
}
