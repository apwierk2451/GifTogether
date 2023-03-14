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
    let gifticonRepository: GifticonRepository
    
    func execute(with item: Gifticon) {
        gifticonRepository.create(item)
    }
}
