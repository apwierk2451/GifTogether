//
//  FetchRecentGifticonQueriesUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation
protocol FetchRecentGifticonQueriesUseCase {
    func execute(maxCount: Int,
                 _ completion: @escaping (Result<[GifticonQuery], Error>) -> Void)
}

final class DefaultFetchRecentGifticonQueriesUseCase: FetchRecentGifticonQueriesUseCase {
    private let gifticonQueriesRepository: GifticonQueriesRepository
    
    init(gifticonQueriesRepository: GifticonQueriesRepository) {
        self.gifticonQueriesRepository = gifticonQueriesRepository
    }
    
    func execute(maxCount: Int,
                 _ completion: @escaping (Result<[GifticonQuery], Error>) -> Void) {
        gifticonQueriesRepository.fetchRecentQueries(
            maxCount: maxCount,
            completion: completion
        )
    }
}
