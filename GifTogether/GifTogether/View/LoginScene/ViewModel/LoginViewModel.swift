//
//  LoginViewModel.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import Foundation
import Combine

final class LoginViewModel: ObservableObject {
    private let loginUseCase: LoginUseCase
    private let createUserUseCase: CreateUserUseCase
    private let verifyPhoneNumberUseCase: RequestVerificationCodeUseCase
    private let verifyCodeUseCase: VerifyCodeUseCase
    
    @Published var isSuccessLogin: Bool = false
    @Published var isSuccessSignup: Bool = false
    
    init(
        loginUseCase: LoginUseCase,
        createUserUseCase: CreateUserUseCase,
        verifyPhoneNumberUseCase: RequestVerificationCodeUseCase,
        verifyCodeUseCase: VerifyCodeUseCase
    ) {
        self.loginUseCase = loginUseCase
        self.createUserUseCase = createUserUseCase
        self.verifyPhoneNumberUseCase = verifyPhoneNumberUseCase
        self.verifyCodeUseCase = verifyCodeUseCase
    }
    
    func login(with email: String, password: String, _ completion: @escaping (Bool) -> Void) {
        loginUseCase.execute(with: email, password: password) { [weak self] userUID in
            if let userUID = userUID {
                self?.isSuccessLogin = true
                UserDefaults.standard.set(userUID, forKey: "userUID")
                completion(true)
            } else {
                self?.isSuccessLogin = false
                completion(false)
            }
        }
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: "userUID")
    }
    
    func createUser(with loginInfo: LoginInfo, _ completion: @escaping (Bool) -> Void) {
        
        createUserUseCase.execute(with: loginInfo) { [weak self] userUID in
            if userUID != nil {
                self?.isSuccessSignup = true
                completion(true)
            } else {
                self?.isSuccessSignup = false
                completion(false)
            }
        }
    }
    
    func verifyPhoneNumber(phoneNumber: String,
                           _ completion: @escaping (Bool) -> Void) {
        verifyPhoneNumberUseCase.execute(
            phoneNumber: phoneNumber,
            completion
        )
    }
    
    func verifyCode(verificationCode: String,
                    _ completion: @escaping (Bool) -> Void) {
        verifyCodeUseCase.execute(
            verificationCode: verificationCode,
            completion
        )
    }
}
