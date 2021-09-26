//
//  DetailViewModel.swift
//  DigioStore
//
//  Created by Mailson Costa on 26/09/21.
//

import Foundation

class DetailViewModel {

    private var productData: DigioStoreProduct?

    init(_ data: DigioStoreProduct) {
        loadImageData(using: data.pImageURL)
        DetailLoader.delegate?.fillViewData(title: data.pName, description: data.pDescription)
    }

    private func loadImageData(using url: String) {
        NetworkHelper.downloadImage(from: URL.init(string: url)!, completion: { data in
            if let data = data {
                DetailLoader.delegate?.imageSucessfulLoaded(data)
            }
        })
    }

}
