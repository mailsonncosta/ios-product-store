//
//  DigioProductManager.swift
//  DigioStore
//
//  Created by Mailson Costa on 25/09/21.
//

import UIKit
import CoreData

class DigioProductsManager {
 
    // MARK: Contexts

    let backgroundcontext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext

    // MARK: - Init

    init(mainContext: NSManagedObjectContext = CoreDataStack.shared.mainContext,
         backgroundContext: NSManagedObjectContext = CoreDataStack.shared.backgroundContext) {
        self.mainContext = mainContext
        self.backgroundcontext = backgroundContext
    }

    // MARK: - Create

    func create<T>(productData: DigioStoreProduct, entityObject: T) {
        backgroundcontext.performAndWait {
            switch T.self {
            case is Spotlight.Type: createSpotlight(productData)
            case is Cash.Type: createCash(productData)
            case is Product.Type: createProduct(productData)
            default:
                break
            }
        }
    }

    private func createSpotlight(_ productData: DigioStoreProduct) {
        let spotlight = NSEntityDescription.insertNewObject(forEntityName: "Spotlight", into: backgroundcontext) as! Spotlight
        spotlight.name = productData.pName
        spotlight.spotlightDescription = productData.pDescription
        spotlight.bannerURL = productData.pImageURL
        
        try? backgroundcontext.save()
    }

    private func createProduct(_ productData: DigioStoreProduct) {
        let product = NSEntityDescription.insertNewObject(forEntityName: "Product", into: backgroundcontext) as! Product
        product.name = productData.pName
        product.productDescription = productData.pDescription
        product.imageURL = productData.pImageURL
        
        try? backgroundcontext.save()
    }

    private func createCash(_ productData: DigioStoreProduct) {
        let cash = NSEntityDescription.insertNewObject(forEntityName: "Cash", into: backgroundcontext) as! Cash
        cash.title = productData.pName
        cash.cashDescription = productData.pDescription
        cash.bannerURL = productData.pImageURL

        try? backgroundcontext.save()
    }

    // MARK: - Deletion

    func delete(object: NSManagedObject) {
        let objectID = object.objectID
        backgroundcontext.performAndWait {
            if let objectInContext = try? backgroundcontext.existingObject(with: objectID) {
                backgroundcontext.delete(objectInContext)
                try? backgroundcontext.save()
            }
        }
    }

    // MARK: - Update

    func update(object: NSManagedObject) {
        backgroundcontext.performAndWait {
            do {
                try backgroundcontext.save()
            } catch let error {
                print("Failed to update: \(error)")
            }
        }
    }

    // MARK: - Fetch
    // MARK: - Fetch Cash

    func fetchCash(withName name: String) -> Cash? {
        let fetchRequest = NSFetchRequest<Cash>(entityName: "Cash")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "title == %@", name)
        
        var cash: Cash?
        
        mainContext.performAndWait {
            do {
                let cashData = try mainContext.fetch(fetchRequest)
                cash = cashData.first
            } catch let error {
                print("Failed to fetch Cash data: \(error)")
            }
        }

        return cash
    }

    // MARK: - Fetch Product

    func fetchProduct(withName name: String) -> Product? {
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        var product: Product?
        
        mainContext.performAndWait {
            do {
                let products = try mainContext.fetch(fetchRequest)
                product = products.first
            } catch let error {
                print("Failed to fetch Product data: \(error)")
            }
        }
        
        return product
    }

    func fetchProducts() -> [Product]? {
        let fetchRequest = NSFetchRequest<Product>(entityName: "Product")
        
        var products: [Product]?
        
        mainContext.performAndWait {
            do {
                products = try mainContext.fetch(fetchRequest)
            } catch let error {
                print("Failed to fetch products: \(error)")
            }
        }
        
        return products
    }
    
    // MARK: - Fetch Spotlight

    func fetchSpotlight(withName name: String) -> Spotlight? {
        let fetchRequest = NSFetchRequest<Spotlight>(entityName: "Spotlight")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        var spotlight: Spotlight?
        
        mainContext.performAndWait {
            do {
                let spotlights = try mainContext.fetch(fetchRequest)
                spotlight = spotlights.first
            } catch let error {
                print("Failed to fetch Spotlight data: \(error)")
            }
        }
        
        return spotlight
    }

    func fetchSpotlights() -> [Spotlight]? {
        let fetchRequest = NSFetchRequest<Spotlight>(entityName: "Spotlight")
        
        var spotlights: [Spotlight]?
        
        mainContext.performAndWait {
            do {
                spotlights = try mainContext.fetch(fetchRequest)
            } catch let error {
                print("Failed to fetch spotlights: \(error)")
            }
        }
        
        return spotlights
    }
}
