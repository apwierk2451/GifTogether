//
//  DeleteGifticonUseCase.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/17.
//

import Foundation

protocol DeleteGifticonUseCase {
    func execute(gifticonUUID: String, userInfo: UserInfo, _ completion: @escaping () -> Void)
}

final class DefaultDeleteGifticonUseCase: DeleteGifticonUseCase {
    private let gifticonRepository: GifticonRepository
    private let userInfoRepository: UserInfoRepository
    
    init(
        gifticonRepository: GifticonRepository,
        userInfoRepository: UserInfoRepository
    ) {
        self.gifticonRepository = gifticonRepository
        self.userInfoRepository = userInfoRepository
    }
    
    func execute(gifticonUUID: String, userInfo: UserInfo, _ completion: @escaping () -> Void) {
        userInfoRepository.update(documentId: userInfo.uuid, to: userInfo)
        gifticonRepository.delete(documentId: gifticonUUID)
        completion()
    }
}
