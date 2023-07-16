//
//  CoreDataManager.swift
//  CoreDataTM
//
//  Created by ForMore on 21/06/2023.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentStoreContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init() {
        persistentStoreContainer = NSPersistentContainer(name: "TMDataModel")
        persistentStoreContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
}
