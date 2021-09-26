//
//  HomeViewModel.swift
//  DigioStore
//
//  Created by Mailson Costa on 26/09/21.
//

import Foundation
import CoreData
import UIKit

class HomeViewModel {

    var products = [Product]()
    var spotlights = [Spotlight]()
    var cash = Cash.init()

    private(set) var productData: DigioStoreProduct?
    private var context: NSManagedObjectContext?

    init() {
        //swiftlint:disable:next force_cast
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        getProductsFromServer()
    }

    func setSelectedProduct(_ product: DigioStoreProduct) {
        productData = product
    }

    func loadImageData(using url: String) {
        NetworkHelper.downloadImage(from: URL.init(string: url)!, completion: { data in
            if let data = data {
                DetailLoader.delegate?.imageSucessfulLoaded(data)
            }
        })
    }

    private func getProductsFromServer() {
        DigioApi.getProducts(completion: { response, error in
            if error != nil {
                print("error")
            } else {
                self.fillDigioProducts(from: response)
            }
        })
    }

    private func fillDigioProducts(from response: [String: Any]) {
        do {
            //swiftlint:disable:next force_cast
            try fillProductsData(dictionary: response["products"] as! [[String: Any]])
            //swiftlint:disable:next force_cast
            try fillSpotlightsData(dictionary: response["spotlight"] as! [[String: Any]])
            //swiftlint:disable:next force_cast
            try fillCashData(dictionary: response["cash"] as! [String: Any])
        } catch {
            print("Failed to fill digio products")
        }

        HomeLoader.delegate?.updateCollectionData()
    }

    private func fillProductsData(dictionary: [[String: Any]]) throws {
        for product in dictionary {
            products.append(try Product(context: context!, dictionary: product))
        }
    }

    private func fillSpotlightsData(dictionary: [[String: Any]]) throws {
        for spotlight in dictionary {
            spotlights.append(try Spotlight(context: context!, dictionary: spotlight))
        }
    }

    private func fillCashData(dictionary: [String: Any]) throws {
        cash = try Cash(context: context!, dictionary: dictionary)
        NetworkHelper.downloadImage(from: URL.init(string: self.cash.pImageURL)!, completion: { data in
            if let data = data {
                HomeLoader.delegate?.cashImageSucessfulLoaded(data)
            }
        })
    }

}
