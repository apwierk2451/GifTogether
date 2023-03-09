//
//  RegisterGifticonUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

protocol RegisterGifticonUseCase {
    func execute(with item: Gifticon)
}

struct DefaultRegisterGifticonUseCase: RegisterGifticonUseCase {
    let firestoreRepository: FirestoreRepository
    
    func execute(with item: Gifticon) {
        firestoreRepository.create(item)
    }
}
