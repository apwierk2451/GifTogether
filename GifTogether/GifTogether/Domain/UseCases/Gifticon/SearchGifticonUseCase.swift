//
//  SearchGifticonUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation

protocol SearchGifticonUseCase {
    func execute(searchText: String,
                 completion: @escaping (Result<[Gifticon],Error>) -> Void)
}

final class DefaultSearchGifticonUseCase: SearchGifticonUseCase {

    private let gifticonRepository: GifticonRepository
    private let gifticonQueriesRepository: GifticonQueriesRepository
    
    init(
        gifticonRepository: GifticonRepository,
        gifticonQueriesRepository: GifticonQueriesRepository
    ) {
        self.gifticonRepository = gifticonRepository
        self.gifticonQueriesRepository = gifticonQueriesRepository
    }
    
    func execute(searchText: String,
                 completion: @escaping (Result<[Gifticon], Error>) -> Void) {
        gifticonRepository.read { [weak self] allGifticon in
            guard let allGifticon = allGifticon else {
                completion(.failure(FirestoreError.readError))
                return
            }
            let filteredResult = allGifticon.filter {
                $0.name.hasPrefix(searchText)
            }
            completion(.success(filteredResult))
            self?.gifticonQueriesRepository.saveRecentQuery(query: .init(query: searchText)) { _ in }
        }
    }
}
