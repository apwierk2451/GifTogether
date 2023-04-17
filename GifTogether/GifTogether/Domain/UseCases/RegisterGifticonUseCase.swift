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
    let userInfoRepository: UserInfoRepository
    let gifticonRepository: GifticonRepository
    
    func execute(with item: Gifticon) {
        gifticonRepository.create(item)
        guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
            return
        }
        userInfoRepository.readOne(uuid: userUID) { userInfo in
            guard var userInfo = userInfo else { return }
            userInfo.salesList.append(item.uuid)
            userInfoRepository.update(documentId: userUID, to: userInfo)
        }
    }
}
