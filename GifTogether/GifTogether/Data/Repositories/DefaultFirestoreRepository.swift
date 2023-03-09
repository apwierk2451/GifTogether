//
//  DefaultFirestoreRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

final class DefaultFirestoreRepository: FirestoreRepository {
    
    func create(_ entity: Entity) {
        // TODO: entity 생성
    }
    
    func read() -> [Entity] {
        // TODO: entity 읽어오기
        return []
    }
    
    func update(_ entity: Entity, to modifiedEntity: Entity) {
        // TODO: entity 업데이트, 변경
        
    }
    
    func delete(_ entity: Entity) {
        // TODO: entity 삭제
    }
}
