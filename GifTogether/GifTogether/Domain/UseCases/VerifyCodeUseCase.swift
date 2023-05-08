//
//  VerifyCodeUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/26.
//

import FirebaseAuth

protocol VerifyCodeUseCase {
    func execute(verificationCode: String,
                 _ completion: @escaping (Bool) -> Void)
}

final class DefaultVerifyCodeUseCase: VerifyCodeUseCase {
    private let firebaseAuthService: FirebaseAuthService
    
    init(firebaseAuthService: FirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func execute(verificationCode: String,
                 _ completion: @escaping (Bool) -> Void) {
        
        firebaseAuthService.verifyCode(verificationCode: verificationCode, completion)
    }
}
