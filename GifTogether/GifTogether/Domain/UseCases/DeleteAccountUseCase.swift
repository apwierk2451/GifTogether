//
//  DeleteAccountUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/04.
//

import FirebaseAuth

protocol DeleteAccountUseCase {
    func execute(_ completion: @escaping (Bool) -> Void)
}

final class DefaultDeleteAccountUseCase: DeleteAccountUseCase {
    private let firebaseAuthService: FirebaseAuthService
    private let userInfoRepository: UserInfoRepository
    
    init(
        firebaseAuthService: FirebaseAuthService,
        userInfoRepository: UserInfoRepository
    ) {
        self.firebaseAuthService = firebaseAuthService
        self.userInfoRepository = userInfoRepository
    }
    
    func execute(_ completion: @escaping (Bool) -> Void) {
        firebaseAuthService.deleteAccount()
        guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
            completion(false)
            return
        }
        userInfoRepository.delete(documentId: userUID)
        UserDefaults.standard.removeObject(forKey: "userUID")
        completion(true)
    }
}
