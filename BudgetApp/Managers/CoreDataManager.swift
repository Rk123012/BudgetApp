//
//  CoreDataManager.swift
//  BudgetApp
//
//  Created by Rezaul Karim on 13/1/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private var persistentContainer : NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "BudgetModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error{
                print("Error loading persistent store: \(error)")
            }
        }
    
    }
    
    var viewContext : NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    
}
