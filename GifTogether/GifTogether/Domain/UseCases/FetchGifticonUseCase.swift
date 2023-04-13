//
//  FetchGifticonUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/12.
//

import Foundation
protocol FetchGifticonUseCase {
    func execute(uuid: String, _ completion: @escaping (Gifticon?) -> Void)
}

struct DefaultFetchGifticonUseCase: FetchGifticonUseCase {
    let gifticonRepository: GifticonRepository
    
    func execute(uuid: String, _ completion: @escaping (Gifticon?) -> Void) {
        gifticonRepository.readOne(uuid: uuid) { gifticon in
            completion(gifticon)
        }
    }
}
