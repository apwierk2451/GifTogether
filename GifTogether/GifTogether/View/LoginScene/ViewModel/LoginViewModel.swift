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
    
    @Published var isSuccessLogin: Bool = false
    @Published var isSuccessSignup: Bool = false
    
    init(loginUseCase: LoginUseCase, createUserUseCase: CreateUserUseCase) {
        self.loginUseCase = loginUseCase
        self.createUserUseCase = createUserUseCase
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
}
