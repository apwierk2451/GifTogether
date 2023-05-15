//
//  DeleteAccountUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/04.
//

import FirebaseAuth

protocol DeleteAccountUseCase {
    func execute(_ completion: @escaping (Bool) -> Void)
}

final class DefaultDeleteAccountUseCase: DeleteAccountUseCase {
    private let firebaseAuthService: FirebaseAuthService
    private let userInfoRepository: UserInfoRepository
    private let gifticonRepository: GifticonRepository
    private let firestorageRepository: FirestorageRepository
    
    init(
        firebaseAuthService: FirebaseAuthService,
        userInfoRepository: UserInfoRepository,
        gifticonRepository: GifticonRepository,
        firestorageRepository: FirestorageRepository
    ) {
        self.firebaseAuthService = firebaseAuthService
        self.userInfoRepository = userInfoRepository
        self.gifticonRepository = gifticonRepository
        self.firestorageRepository = firestorageRepository
    }
    
    func execute(_ completion: @escaping (Bool) -> Void) {
        firebaseAuthService.deleteAccount()
        guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
            completion(false)
            return
        }
        userInfoRepository.readOne(uuid: userUID) { [weak self] userInfo in
            guard let self = self else { return }
            guard let userInfo = userInfo else { return }
            
            userInfo.salesList.forEach { documentId in
                self.firestorageRepository.delete(fileName: documentId) { isDeleted in
                    if isDeleted {
                        self.gifticonRepository.delete(documentId: documentId)
                    } else {
                        print("기프티콘 이미지 삭제에 실패했습니다.")
                    }
                }
            }
            // 사진과 기프티콘 모두 삭제할 때까지 대기...해야됨
            // 유저 데이터를 삭제중입니다 ProgressBar 표시하면 좋을듯
            self.userInfoRepository.delete(documentId: userUID)
            UserDefaults.standard.removeObject(forKey: "userUID")
            completion(true)
        }
    }
}
