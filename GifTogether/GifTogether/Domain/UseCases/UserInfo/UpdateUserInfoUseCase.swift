//
//  UpdateUserInfoUseCase.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/05.
//

protocol UpdateUserInfoUseCase {
    func execute(userUID: String, userInfo: UserInfo)
}

struct DefaultUpdateUserInfoUseCase: UpdateUserInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(userInfoRepository: UserInfoRepository) {
        self.userInfoRepository = userInfoRepository
    }
    
    func execute(userUID: String, userInfo: UserInfo) {
        userInfoRepository.update(documentId: userUID, to: userInfo)
    }
}
