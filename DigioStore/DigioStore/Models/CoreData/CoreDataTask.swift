//
//  CoreDataTask.swift
//  DigioStore
//
// Managers can do operations via the:
// - `mainContext` with interacts on the main UI thread, or
// - `backgroundContext` with has a separate queue for background processing
//
//  Created by Mailson Costa on 25/09/21.
//

import Foundation
import CoreData

class CoreDataStack {

    static let shared = CoreDataStack()

    let persistentContainer: NSPersistentContainer
    let backgroundContext: NSManagedObjectContext
    let mainContext: NSManagedObjectContext

    private init() {
        persistentContainer = NSPersistentContainer(name: "DigioStoreProducts")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = NSSQLiteStoreType

        persistentContainer.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("was unable to load store \(error!)")
            }
        }

        mainContext = persistentContainer.viewContext

        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        backgroundContext.parent = self.mainContext
    }
}
