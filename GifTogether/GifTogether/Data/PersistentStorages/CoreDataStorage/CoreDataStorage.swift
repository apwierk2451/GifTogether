//
//  CoreDataStorage.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import CoreData

enum CoreDataStorageError: Error {
    case readError(Error)
    case saveError(Error)
    case deleteError(Error)
}

final class CoreDataStorage {
    static let shared = CoreDataStorage()
    
    private init() {}
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataStorage")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
        }
    }

    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
    
    func delete(entity: GifticonQuery) {
        let context = persistentContainer.viewContext
        context.delete(GifticonQueryEntity(gifticonQuery: entity, insertInto: context))
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAll() -> Bool {
        let request: NSFetchRequest<NSFetchRequestResult> = GifticonQueryEntity.fetchRequest()
        let delete = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try persistentContainer.viewContext.execute(delete)
            return true
        } catch {
            return false
        }
    }
}
