//
//  FetchUseInfoUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

protocol FetchUseInfoUseCase {
    func execute(with userUID: String,
                 _ completion: @escaping (UserInfo) -> Void)
}

final class DefaultFetchUseInfoUseCase: FetchUseInfoUseCase {
    private let userInfoRepository: UserInfoRepository
    
    init(userInfoRepository: UserInfoRepository) {
        self.userInfoRepository = userInfoRepository
    }
    
    func execute(with userUID: String,
                 _ completion: @escaping (UserInfo) -> Void) {
        
        userInfoRepository.read { userInfoList in
            if let userInfoList = userInfoList {
                let userInfo = userInfoList.filter { $0.uuid == userUID }[0]
                completion(userInfo)
            }
        }
    }
}
