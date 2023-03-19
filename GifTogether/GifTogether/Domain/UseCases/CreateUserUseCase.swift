//
//  CreateUserUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

struct LoginInfo {
    let id: String
    let password: String
    let vendorName: String
    let phoneNumber: String
}

protocol CreateUserUseCase {
    func execute(with loginInfo: LoginInfo, _ completion: @escaping (String?) -> Void)
}

final class DefaultCreateUserUseCase: CreateUserUseCase {
    private let firebaseAuthService: FirebaseAuthService
    private let userInfoRepository: UserInfoRepository
    
    init(
        firebaseAuthService: FirebaseAuthService,
        firestoreService: UserInfoRepository
    ) {
        self.firebaseAuthService = firebaseAuthService
        self.userInfoRepository = firestoreService
    }
    
    func execute(with loginInfo: LoginInfo, _ completion: @escaping (String?) -> Void) {
        firebaseAuthService.createUser(email: loginInfo.id, password: loginInfo.password ) { [weak self] userUID in
            guard let userUID = userUID else {
                completion(nil)
                return
            }
            let email = loginInfo.id
            let vendorName = loginInfo.vendorName
            let phoneNumber = loginInfo.phoneNumber
            let userInfo = UserInfo(
                uuid: userUID,
                name: vendorName,
                email: email,
                phoneNumber: phoneNumber
            )
            
            self?.userInfoRepository.create(userInfo)
            completion(userUID)
        }
    }
}
