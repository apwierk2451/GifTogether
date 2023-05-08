//
//  ReportRepository.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/05/07.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

final class ReportRepository: FirestoreRepository {
    
    typealias T = Report
    private let db = Firestore.firestore()
    
    func create(_ entity: Report) {
    
        let dictionary = entity.toDictionary()

        db.collection(Report.id)
            .document(entity.uuid)
            .setData(dictionary)
    }
    
    func read(_ completion: @escaping ([Report]?) -> Void) {
        db.collection(Report.id).getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                var reportList = [Report]()
                for document in querySnapshot!.documents {
                    let dic = document.data()
                    let report = Report.toEntity(dic: dic)
                    reportList.append(report)
                }
                completion(reportList)
            }
        }
    }
    
    func readOne(uuid: String, _ completion: @escaping (Report?) -> Void) {
        db.collection(Report.id)
            .document(uuid)
            .getDocument { documentSnapshot, error in
                guard error == nil else {
                    completion(nil)
                    return
                }
                guard let dic = documentSnapshot?.data() else {
                    completion(nil)
                    return
                }
                let report = Report.toEntity(dic: dic)
                completion(report)
            }
    }
    
    func update(documentId: String, to modifiedEntity: Report) {
        db.collection(Report.id)
            .document(documentId)
            .setData(modifiedEntity.toDictionary())
    }
    
    func delete(documentId: String) {
        db.collection(Report.id)
            .document(documentId)
            .delete()
    }
}
