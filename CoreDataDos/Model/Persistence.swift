//
//  Persistence.swift
//  CoreDataDos
//
//  Created by Paul Jaime Felix Flores on 11/05/23.
//
import SwiftUI

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataDos")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}




