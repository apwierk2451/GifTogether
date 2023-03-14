//
//  GifticonRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class GifticonRepository: FirestoreRepository {
    typealias T = Gifticon
    private let db = Firestore.firestore()
    
    func create(_ entity: Gifticon) {
    
        let dictionary = entity.toDictionary()

        db.collection(Gifticon.id)
            .document(entity.uuid)
            .setData(dictionary)
    }
    
    func read(_ completion: @escaping ([Gifticon]?) -> Void) {
        db.collection(Gifticon.id).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var gifticons = [Gifticon]()
                for document in querySnapshot!.documents {
                    let dic = document.data()
                    let gifticon = Gifticon.toEntity(dic: dic)
                    gifticons.append(gifticon)
                }
                completion(gifticons)
            }
        }
    }
    
    func update(documentId: String, to modifiedEntity: Gifticon) {
        db.collection(Gifticon.id)
            .document(documentId)
            .setData(modifiedEntity.toDictionary())
    }
    
    func delete(documentId: String) {
        db.collection(Gifticon.id)
            .document(documentId)
            .delete()
    }
}
