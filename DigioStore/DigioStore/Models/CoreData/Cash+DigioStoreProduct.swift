//
//  Cash+DigioStoreProduct.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

extension Cash: DigioStoreProduct {
    public var pName: String {
        return title ?? ""
    }

    public var pDescription: String {
        return cashDescription ?? ""
    }

    public var pImageURL: String {
        return bannerURL ?? ""
    }
}
