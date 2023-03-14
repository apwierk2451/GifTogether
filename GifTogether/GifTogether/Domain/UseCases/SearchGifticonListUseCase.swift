//
//  SearchGifticonListUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

protocol SearchGifticonListUseCase {
    func execute(_ completion: @escaping ([Gifticon]) -> Void)
}

struct DefaultSearchGifticonListUseCase: SearchGifticonListUseCase {
    let gifticonRepository: GifticonRepository
    
    func execute(_ completion: @escaping ([Gifticon]) -> Void) {
        gifticonRepository.read { list in
            guard let list = list else { return }
            completion(list)
        }
    }
}
