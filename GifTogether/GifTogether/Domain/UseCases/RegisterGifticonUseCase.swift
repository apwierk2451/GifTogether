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
        userInfoRepository.read { userInfoList in
            guard let userInfoList = userInfoList else { return }
            var fetchedUserInfo = userInfoList.filter { $0.uuid == userUID }[0]
            fetchedUserInfo.salesList.append(item.uuid)
            userInfoRepository.update(documentId: userUID, to: fetchedUserInfo)
        }
    }
}
