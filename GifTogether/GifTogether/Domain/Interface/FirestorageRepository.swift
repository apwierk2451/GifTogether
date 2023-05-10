//
//  FirestorageRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/05/03.
//

import Foundation

protocol FirestorageRepository {
    
    func putData(with data: Data,
                 to fileName: String,
                 _ completion: @escaping (URL?) -> Void)
    
    func delete(fileName: String,
                _ completion: @escaping (Bool) -> Void)
}
