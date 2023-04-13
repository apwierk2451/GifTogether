//
//  FirestoreRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

protocol FirestoreRepository {
    associatedtype T: Entity
    
    func create(_ entity: T)
    func read(_ completion: @escaping ([T]?) -> Void)
    func readOne(uuid: String, _ completion: @escaping (T?) -> Void)
    func update(documentId: String, to modifiedEntity: T)
    func delete(documentId: String)
}

enum FirestoreError: LocalizedError {
    case readError
    
    var errorDescription: String? {
        switch self {
        case .readError:
            return "Firestore 데이터 읽어오기에 실패했습니다."
        }
    }
}
