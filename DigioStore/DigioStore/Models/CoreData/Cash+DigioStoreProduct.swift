//
//  Cash+DigioStoreProduct.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

extension Cash: DigioStoreProduct {
    public var pName: String {
        return title ?? "Título não encontrado"
    }

    public var pDescription: String {
        return cashDescription ?? "Descrição não encontrada"
    }

    public var pImageURL: String {
        return bannerURL ?? ""
    }
}
