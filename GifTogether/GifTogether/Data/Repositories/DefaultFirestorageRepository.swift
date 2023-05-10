//
//  DefaultFirestorageRepository.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/05/03.
//

import Foundation
import FirebaseStorage

final class DefaultFirestorageRepository: FirestorageRepository {
    private let storage = Storage.storage()
    
    func putData(with data: Data, to fileName: String, _ completion: @escaping (URL?) -> Void) {
        let storageRef = storage.reference()
        let riverRef = storageRef.child("images/\(fileName).jpg")
        
        let uploadTask = riverRef.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(nil)
                return
            }
            let size = metadata.size
            riverRef.downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                guard let downloadURL = url else {
                    completion(nil)
                    return
                }
                completion(downloadURL)
            }
        }
        uploadTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount)
                                        / Double(snapshot.progress!.totalUnitCount)
            print("진행상황 \(percentComplete)%")
            
        }
    }
    
    func delete(fileName: String, _ completion: @escaping (Bool) -> Void) {
        let storageRef = storage.reference()
        let desertRef = storageRef.child("images/\(fileName).jpg")
        desertRef.delete { error in
            if let error = error {
                print(error.localizedDescription)
                completion(false)
            } else {
                print("삭제 성공!")
                completion(true)
            }
        }
    }
}
