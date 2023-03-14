//
//  FirebaseAuthService.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/12.
//

import FirebaseAuth

protocol FirebaseAuthService {
    func createUser(email: String,
                    password: String,
                    _ completion: @escaping (String?) -> Void)
    func logIn(email: String,
               password: String,
               _ completion: @escaping (String?) -> Void)
    func fetchUserUID() throws -> String
}

enum FirebaseAuthServiceError: LocalizedError {
    case failToCreateUser
    case failToLogin
    case failToFetch
    
    var errorDescription: String? {
        switch self {
        case .failToCreateUser:
            return "사용자 계정을 생성하지 못했습니다."
        case .failToLogin:
            return "사용자를 찾을 수 없습니다."
        case .failToFetch:
            return "사용자 정보를 가져오지 못했습니다."
        }
    }
}
