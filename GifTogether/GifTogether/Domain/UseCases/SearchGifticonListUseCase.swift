//
//  SearchGifticonListUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

protocol SearchGifticonListUseCase {
    func execute() -> [Gifticon]
}

struct DefaultSearchGifticonList: SearchGifticonListUseCase {
    let firestoreRepository: FirestoreRepository
    
    func execute() -> [Gifticon] {
        firestoreRepository.read().compactMap {
            $0 as? Gifticon
        }
    }
}
