//
//  LoginUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

import FirebaseAuth

protocol LoginUseCase {
    func execute(with email: String,
                 password: String,
                 _ completion: @escaping (String?) -> Void)
}

final class DefaultLoginUseCase: LoginUseCase {
    private let firebaseAuthService: FirebaseAuthService
    
    init(firebaseAuthService: FirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func execute(with email: String,
                 password: String,
                 _ completion: @escaping (String?) -> Void) {
        
        firebaseAuthService.logIn(
            email: email,
            password: password
        ) { userUID in
            completion(userUID)
        }
    }
}
