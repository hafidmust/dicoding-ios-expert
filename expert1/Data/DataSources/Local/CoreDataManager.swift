//
//  CoreDataManager.swift
//  expert1
//
//  Created by Hafid Ali Mustaqim on 29/03/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "FavoriteItem")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("CoreDataManager: Unable to load persistent store: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("CoreDataManager: Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
