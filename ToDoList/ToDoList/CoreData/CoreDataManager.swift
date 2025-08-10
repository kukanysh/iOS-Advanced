//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 10.08.2025.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ToDoModel") // Make sure this matches your .xcdatamodeld file name
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("CoreData load error: \(error)")
            }
        }
        
        // Configure contexts for better performance
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // Main context for UI operations (main thread)
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    // Background context for heavy operations
    var backgroundContext: NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    // MARK: - Save Context
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error: \(error)")
            }
        }
    }
}
