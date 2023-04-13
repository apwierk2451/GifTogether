//
//  SearchBrandUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/10.
//

import Foundation

protocol SearchBrandUseCase {
    func execute(searchBrand: Brand,
                 completion: @escaping (Result<[Gifticon],Error>) -> Void)
}

final class DefaultSearchBrandUseCase: SearchBrandUseCase {

    private let gifticonRepository: GifticonRepository
    
    init(
        gifticonRepository: GifticonRepository
    ) {
        self.gifticonRepository = gifticonRepository
    }
    
    func execute(searchBrand: Brand,
                 completion: @escaping (Result<[Gifticon], Error>) -> Void) {
        gifticonRepository.read { allGifticon in
            guard let allGifticon = allGifticon else {
                completion(.failure(FirestoreError.readError))
                return
            }
            let filteredResult = allGifticon.filter {
                $0.brand == searchBrand
            }
            completion(.success(filteredResult))
        }
    }
}
