//
//  ProductsTest.swift
//  DigioStoreTests
//
//  Created by Mailson Costa on 25/09/21.
//

import XCTest
import CoreData
@testable import DigioStore

class ProductsTest: XCTestCase {
    
    var digioStoreProductManager: DigioProductsManager!
    var coreDataTestStack: CoreDataTestStack!
    
    override func setUp() {
        super.setUp()
        coreDataTestStack = CoreDataTestStack()
        digioStoreProductManager = DigioProductsManager(mainContext: coreDataTestStack.mainContext,
                                                        backgroundContext: coreDataTestStack.mainContext)
    }
    
    func testCreateProduct() {
        createProduct(using: ProductsSample.product01)
        let product = digioStoreProductManager.fetchProduct(withName: ProductNames.name1)!

        XCTAssertEqual(ProductNames.name1, product.name)
    }
    
    func testUpdateProduct() {
        createProduct(using: ProductsSample.product01)
        let product = digioStoreProductManager.fetchProduct(withName: ProductNames.name1)!
        product.name = ProductNames.name2
        digioStoreProductManager.update(object: product)
        
        XCTAssertNotEqual(ProductNames.name1, product.name)
        XCTAssertEqual(ProductNames.name2, product.name)
    }
        
    func testDeleteProducts() {
        createProduct(using: ProductsSample.product01)
        createProduct(using: ProductsSample.product02)
        createProduct(using: ProductsSample.product03)
        
        let product01 = digioStoreProductManager.fetchProduct(withName: ProductNames.name1)!
        let product02 = digioStoreProductManager.fetchProduct(withName: ProductNames.name2)!
        let product03 = digioStoreProductManager.fetchProduct(withName: ProductNames.name3)!
        
        digioStoreProductManager.delete(object: product02)

        let products = digioStoreProductManager.fetchProducts()!

        XCTAssertEqual(products.count, 2)
        XCTAssertTrue(products.contains(product01))
        XCTAssertTrue(products.contains(product03))
    }
    
    private func createProduct(using sample: [String: Any]) {
        let product = try! Product(context: coreDataTestStack.mainContext, dictionary: sample) as Product
        digioStoreProductManager.create(productData: product, entityObject: Product.self )
    }
}
