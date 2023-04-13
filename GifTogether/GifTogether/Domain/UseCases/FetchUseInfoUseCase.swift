//
//  FetchUseInfoUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

protocol FetchUseInfoUseCase {
    func execute(with userUID: String,
                 _ completion: @escaping (UserInfo?) -> Void)
}

final class DefaultFetchUseInfoUseCase: FetchUseInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(userInfoRepository: UserInfoRepository) {
        self.userInfoRepository = userInfoRepository
    }
    
    func execute(with userUID: String,
                 _ completion: @escaping (UserInfo?) -> Void) {
        userInfoRepository.readOne(uuid: userUID) { userInfo in
            completion(userInfo)
        }
    }
}
