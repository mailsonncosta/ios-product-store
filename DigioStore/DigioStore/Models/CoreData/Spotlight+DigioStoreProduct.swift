//
//  Spotlight+DigioStoreProduct.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

extension Spotlight: DigioStoreProduct {
    public var pName: String {
        return name ?? "Nome não encontrado"
    }

    public var pDescription: String {
        return spotlightDescription ?? "Descrição não encontrada"
    }

    public var pImageURL: String {
        return bannerURL ?? ""
    }
}
