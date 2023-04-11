//
//  UpdateGifticonUseCase.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/10.
//

protocol UpdateGifticonUseCase {
    func execute(gifticonUUID: String, gifticon: Gifticon)
}

struct DefaultUpdateGifticonUseCase: UpdateGifticonUseCase {
    private let gifticonRepository: GifticonRepository
    
    init(gifticonRepository: GifticonRepository) {
        self.gifticonRepository = gifticonRepository
    }
    
    func execute(gifticonUUID: String, gifticon: Gifticon) {
        gifticonRepository.update(documentId: gifticonUUID, to: gifticon)
    }
}
