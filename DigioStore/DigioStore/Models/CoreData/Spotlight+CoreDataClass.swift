//
//  Spotlight+CoreDataClass.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//
//

import Foundation
import CoreData

@objc(Spotlight)
public class Spotlight: NSManagedObject {

    enum CodingKeys: String, CodingKey {
        case name, bannerURL, spotlightDescription
    }

    required public convenience init(context: NSManagedObjectContext, dictionary: [String: Any]) throws {
        self.init(context: context)

        self.name = dictionary["name"] as? String
        self.bannerURL = dictionary["bannerURL"] as? String
        self.spotlightDescription = dictionary["description"] as? String
    }

    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)

        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.bannerURL = try values.decode(String.self, forKey: .bannerURL)
        self.spotlightDescription = try values.decode(String.self, forKey: .spotlightDescription)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(bannerURL, forKey: .bannerURL)
        try container.encode(spotlightDescription, forKey: .spotlightDescription)
    }

}
