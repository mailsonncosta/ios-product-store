//
//  SpotlightTest.swift
//  DigioStoreTests
//
//  Created by Mailson Costa on 25/09/21.
//

import XCTest
import CoreData
@testable import DigioStore

class SpotlightTest: XCTestCase {
    
    var digioStoreProductManager: DigioProductsManager!
    var coreDataTestStack: CoreDataTestStack!
    
    override func setUp() {
        super.setUp()
        coreDataTestStack = CoreDataTestStack()
        digioStoreProductManager = DigioProductsManager(mainContext: coreDataTestStack.mainContext,
                                                        backgroundContext: coreDataTestStack.mainContext)
    }
    
    func testCreateSpotlight() {
        createSpotlight(using: SpotlightsSample.spotlight01)
        let spotlight = digioStoreProductManager.fetchSpotlight(withName: ProductNames.name1)!

        XCTAssertEqual(ProductNames.name1, spotlight.name)
    }
    
    func testUpdateSpotlight() {
        createSpotlight(using: SpotlightsSample.spotlight01)
        let spotlight = digioStoreProductManager.fetchSpotlight(withName: ProductNames.name1)!
        spotlight.name = ProductNames.name2
        digioStoreProductManager.update(object: spotlight)
        
        XCTAssertNotEqual(ProductNames.name1, spotlight.name)
        XCTAssertEqual(ProductNames.name2, spotlight.name)
    }
        
    func testDeleteSpotlights() {
        createSpotlight(using: SpotlightsSample.spotlight01)
        createSpotlight(using: SpotlightsSample.spotlight02)
        createSpotlight(using: SpotlightsSample.spotlight03)
        
        let spotlight01 = digioStoreProductManager.fetchSpotlight(withName: ProductNames.name1)!
        let spotlight02 = digioStoreProductManager.fetchSpotlight(withName: ProductNames.name2)!
        let spotlight03 = digioStoreProductManager.fetchSpotlight(withName: ProductNames.name3)!
        
        digioStoreProductManager.delete(object: spotlight02)

        let spotlights = digioStoreProductManager.fetchSpotlights()!

        XCTAssertEqual(spotlights.count, 2)
        XCTAssertTrue(spotlights.contains(spotlight01))
        XCTAssertTrue(spotlights.contains(spotlight03))
    }
    
    private func createSpotlight(using sample: [String: Any]) {
        let spotlight = try! Spotlight(context: coreDataTestStack.mainContext, dictionary: sample) as Spotlight
        digioStoreProductManager.create(productData: spotlight, entityObject: Spotlight.self )
    }
}
