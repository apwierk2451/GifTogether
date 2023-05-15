//
//  RequestVerificationCodeUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/25.
//

import FirebaseAuth

protocol RequestVerificationCodeUseCase {
    func execute(phoneNumber: String,
                 _ completion: @escaping (Bool) -> Void)
}

final class DefaultRequestVerificationCodeUseCase: RequestVerificationCodeUseCase {
    private let firebaseAuthService: FirebaseAuthService
    
    init(firebaseAuthService: FirebaseAuthService) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func execute(phoneNumber: String,
                 _ completion: @escaping (Bool) -> Void) {
        
        firebaseAuthService.requestVerificationCode(
            to: phoneNumber,
            completion
        )
    }
}
