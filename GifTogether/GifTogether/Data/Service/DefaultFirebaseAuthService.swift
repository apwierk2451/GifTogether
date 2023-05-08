//
//  DefaultFirebaseAuthService.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

import FirebaseAuth

final class DefaultFirebaseAuthService: FirebaseAuthService {
    
    func createUser(email: String,
                    password: String,
                    _ completion: @escaping (String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            if let authDataResult = authDataResult {
                completion(authDataResult.user.uid)
            }
        }
    }
    
    func logIn(email: String,
               password: String,
               _ completion: @escaping (String?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            guard error == nil else {
                completion(nil)
                return
            }
            
            if let authDataResult = authDataResult {
                completion(authDataResult.user.uid)
            }
        }
    }
    
    func fetchUserUID() throws -> String {
        if let userUID = Auth.auth().currentUser?.uid {
            return userUID
        } else {
            throw FirebaseAuthServiceError.failToFetch
        }
    }
    
    func deleteAccount() {
        let user = Auth.auth().currentUser
        
        user?.delete(completion: { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("계정 삭제 완료")
            }
        })
    }
    
    func requestVerificationCode(to phoneNumber: String,
                                 _ completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false)
                    return
                }
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                completion(true)
            }
    }
    
    func verifyCode(verificationCode: String,
                    _ completion: @escaping (Bool) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: verificationCode
        )
        Auth.auth().signIn(with: credential) { authResult, error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}
