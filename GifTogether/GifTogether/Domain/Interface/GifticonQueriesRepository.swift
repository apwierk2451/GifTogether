//
//  GifticonQueriesRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation

protocol GifticonQueriesRepository {
    func fetchRecentQueries(
        maxCount: Int,
        completion: @escaping (Result<[GifticonQuery], Error>) -> Void)
    
    func saveRecentQuery(
        query: GifticonQuery,
        completion: @escaping (Result<GifticonQuery, Error>) -> Void)
    
    func deleteQuery(query: GifticonQuery)
    
    func deleteAll() -> Bool
}
