//
//  FirestoreRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

protocol FirestoreRepository {
    func create(_ entity: Entity)
    func read() -> [Entity]
    func update(_ entity: Entity, to modifiedEntity: Entity)
    func delete(_ entity: Entity)
}
