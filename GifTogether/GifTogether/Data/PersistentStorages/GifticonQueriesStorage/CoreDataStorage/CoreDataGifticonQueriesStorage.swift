//
//  CoreDataGifticonQueriesStorage.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation
import CoreData

final class CoreDataGifticonQueriesStorage {
    
    private let maxStorageLimit: Int
    private let coreDataStorage: CoreDataStorage
    
    init(maxStorageLimit: Int, coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.maxStorageLimit = maxStorageLimit
        self.coreDataStorage = coreDataStorage
    }
}

extension CoreDataGifticonQueriesStorage: GifticonQueriesStorage {
   
    func fetchRecentQueries(maxCount: Int,
                            completion: @escaping (Result<[GifticonQuery], Error>) -> Void) {
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let request: NSFetchRequest = GifticonQueryEntity.fetchRequest()
                request.sortDescriptors = [
                    NSSortDescriptor(
                        key: #keyPath(GifticonQueryEntity.createdAt),
                        ascending: false
                    )
                ]
                request.fetchLimit = maxCount
                let result = try context.fetch(request).map { $0.toDomain() }
                completion(.success(result))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
    }
    
    func saveRecentQuery(query: GifticonQuery,
                         completion: @escaping (Result<GifticonQuery, Error>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                try self.cleanUpQueries(for: query, inContext: context)
                let entity = GifticonQueryEntity(
                    gifticonQuery: query,
                    insertInto: context
                )
                try context.save()
                
                completion(.success(entity.toDomain()))
            } catch {
                completion(.failure(CoreDataStorageError.saveError(error)))
            }
        }
    }
    
    func deleteQuery(query: GifticonQuery) {
        coreDataStorage.delete(entity: query)
    }
    
    func deleteAll() -> Bool {
        coreDataStorage.deleteAll()
    }
}

// MARK: - Private Extension
private extension CoreDataGifticonQueriesStorage {

    func cleanUpQueries(for query: GifticonQuery,
                                inContext context: NSManagedObjectContext) throws {
        
        let request: NSFetchRequest = GifticonQueryEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(GifticonQueryEntity.createdAt),
                                                    ascending: false)]
        var result = try context.fetch(request)

        removeDuplicates(for: query, in: &result, inContext: context)
        removeQueries(limit: maxStorageLimit - 1, in: result, inContext: context)
    }

    func removeDuplicates(for query: GifticonQuery,
                                  in queries: inout [GifticonQueryEntity],
                                  inContext context: NSManagedObjectContext) {
        queries
            .filter { $0.query == query.query }
            .forEach { context.delete($0) }
        queries.removeAll { $0.query == query.query }
    }

    func removeQueries(limit: Int,
                               in queries: [GifticonQueryEntity],
                               inContext context: NSManagedObjectContext) {
        
        guard queries.count > limit else { return }

        queries.suffix(queries.count - limit)
            .forEach { context.delete($0) }
    }
}
