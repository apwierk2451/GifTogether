//
//  RegisterImageUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/05/03.
//

import Foundation

protocol RegisterImageUseCase {
    func execute(with data: Data,
                 fileName: String,
                 _ completion: @escaping (URL?) -> Void)
}

struct DefaultRegisterImageUseCase: RegisterImageUseCase {
    let firestorageRepository: FirestorageRepository
    
    func execute(with data: Data,
                 fileName: String,
                 _ completion: @escaping (URL?) -> Void) {
        
        firestorageRepository.putData(with: data, to: fileName) { url in
            completion(url)
        }
    }
}
