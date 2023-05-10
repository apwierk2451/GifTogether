//
//  DeleteImageUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/05/09.
//

import Foundation
protocol DeleteImageUseCase {
    func execute(fileName: String,
                 _ completion: @escaping (Bool) -> Void)
}

struct DefaultDeleteImageUseCase: DeleteImageUseCase {
    let firestorageRepository: FirestorageRepository
    
    func execute(fileName: String,
                 _ completion: @escaping (Bool) -> Void) {
        
        firestorageRepository.delete(fileName: fileName, completion)
    }
}
