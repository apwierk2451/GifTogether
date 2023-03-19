//
//  UserInfoRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/14.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class UserInfoRepository: FirestoreRepository {
    typealias T = UserInfo
    private let db = Firestore.firestore()
    
    func create(_ entity: UserInfo) {
    
        let dictionary = entity.toDictionary()

        db.collection(UserInfo.id)
            .document(entity.uuid)
            .setData(dictionary)
    }
    
    func read(_ completion: @escaping ([UserInfo]?) -> Void) {
        db.collection(UserInfo.id).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var userInfoList = [UserInfo]()
                for document in querySnapshot!.documents {
                    let dic = document.data()
                    let userInfo = UserInfo.toEntity(dic: dic)
                    userInfoList.append(userInfo)
                }
                completion(userInfoList)
            }
        }
    }
    
    func update(documentId: String, to modifiedEntity: UserInfo) {
        db.collection(UserInfo.id)
            .document(documentId)
            .setData(modifiedEntity.toDictionary())
    }
    
    func delete(documentId: String) {
        db.collection(UserInfo.id)
            .document(documentId)
            .delete()
    }
}
