//
//  Product+DigioStoreProduct.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

extension Product: DigioStoreProduct {
    public var pName: String {
        return name ?? ""
    }
    
    public var pDescription: String {
        return productDescription ?? ""
    }
    
    public var pImageURL: String {
        return imageURL ?? ""
    }
}
