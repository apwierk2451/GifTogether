//
//  DefaultGifticonQueriesRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation

final class DefaultGifticonQueriesRepository {
    
    private var gifticonQueriesPersistentStorage: GifticonQueriesStorage
    
    init(gifticonQueriesPersistentStorage: GifticonQueriesStorage) {
        self.gifticonQueriesPersistentStorage = gifticonQueriesPersistentStorage
    }
    
}

extension DefaultGifticonQueriesRepository: GifticonQueriesRepository {
    
    func fetchRecentQueries(maxCount: Int,
                            completion: @escaping (Result<[GifticonQuery], Error>) -> Void) {
        gifticonQueriesPersistentStorage.fetchRecentQueries(
            maxCount: maxCount,
            completion: completion
        )
    }
    
    func saveRecentQuery(query: GifticonQuery,
                         completion: @escaping (Result<GifticonQuery, Error>) -> Void) {
        gifticonQueriesPersistentStorage.saveRecentQuery(
            query: query,
            completion: completion
        )
    }
    
    func deleteQuery(query: GifticonQuery) {
        gifticonQueriesPersistentStorage.deleteQuery(query: query)
    }
    
    func deleteAll() -> Bool {
        gifticonQueriesPersistentStorage.deleteAll()
    }
}
