//
//  CashTests.swift
//  DigioStoreTests
//
//  Created by Mailson Costa on 25/09/21.
//

import XCTest
import CoreData
@testable import DigioStore

class CashTests: XCTestCase {

    var digioStoreProductManager: DigioProductsManager!
    var coreDataTestStack: CoreDataTestStack!

    override func setUp() {
        super.setUp()
        coreDataTestStack = CoreDataTestStack()
        digioStoreProductManager = DigioProductsManager(mainContext: coreDataTestStack.mainContext,
                                                        backgroundContext: coreDataTestStack.mainContext)
    }

    func testCreateCash() {
        createCash(using: CashSample.cash01)
        let cash = digioStoreProductManager.fetchCash(withName: ProductNames.name1)!

        XCTAssertEqual(ProductNames.name1, cash.title)
    }

    func testUpdateCash() {
        createCash(using: CashSample.cash01)
        let cash = digioStoreProductManager.fetchCash(withName: ProductNames.name1)!
        cash.title = ProductNames.name2
        digioStoreProductManager.update(object: cash)

        XCTAssertNotEqual(ProductNames.name1, cash.title)
        XCTAssertEqual(ProductNames.name2, cash.title)
    }

    func testDeleteCash() {
        createCash(using: CashSample.cash01)

        let cash01 = digioStoreProductManager.fetchCash(withName: ProductNames.name1)!
        digioStoreProductManager.delete(object: cash01)
        let cash = digioStoreProductManager.fetchCash(withName: ProductNames.name1)

        XCTAssertEqual(cash, nil)
    }

    private func createCash(using sample: [String: Any]) {
        // swiftlint:disable:next force_try
        let spotlight = try! Cash(context: coreDataTestStack.mainContext, dictionary: sample) as Cash
        digioStoreProductManager.create(productData: spotlight, entityObject: Cash.self )
    }
}
