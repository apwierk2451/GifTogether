//
//  FavoriteViewModel.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/04.
//

import Foundation
import Combine

final class FavoriteViewModel: ObservableObject {
    private let fetchUserInfoUseCase: FetchUseInfoUseCase
    private let fetchAllGifticonsUseCase: FetchAllGifticonsUseCase
    private let updateUserInfoUseCase: UpdateUserInfoUseCase
    private let updateGifticonUseCase: UpdateGifticonUseCase
    private let userUID = UserDefaults.standard.object(forKey: "userUID") as? String
    
    @Published var filteredGifticons: [Gifticon] = []
    
    init(
        fetchUserInfoUseCase: FetchUseInfoUseCase,
        fetchAllGifticonsUseCase: FetchAllGifticonsUseCase,
        updateUserInfoUseCase: UpdateUserInfoUseCase,
        updateGifticonUseCase: UpdateGifticonUseCase
    ) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.fetchAllGifticonsUseCase = fetchAllGifticonsUseCase
        self.updateUserInfoUseCase = updateUserInfoUseCase
        self.updateGifticonUseCase = updateGifticonUseCase
    }
    
    func fetchFavoriteGifticons() {
        if let userUID = userUID {
            fetchUserInfoUseCase.execute(with: userUID) { userInfo in
                self.fetchAllGifticonsUseCase.execute { [weak self] gifticons in
                    self?.filteredGifticons = gifticons.filter { userInfo.favoriteList.contains($0.uuid) }
                }
            }
        }
    }
    
    func checkFavortieGifticon(uuid: String, completion: @escaping (Bool) -> Void) {
        if let userUID = userUID {
            fetchUserInfoUseCase.execute(with: userUID) { userInfo in
                if userInfo.favoriteList.contains(uuid) {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func fetchGifticonInfo(gifticonUUID: String, completion: @escaping (Gifticon) -> Void) {
        fetchAllGifticonsUseCase.execute { gifticons in
            let gifticonInfo = gifticons.filter { $0.uuid == gifticonUUID }
            completion(gifticonInfo[0])
        }
    }
    
    func didTappedAddFavoriteButton(to gifticon: Gifticon) {
        var changeGifticon = gifticon
        changeGifticon.favoriteCount += 1
        updateGifticonInfo(gifticonUUID: gifticon.uuid, to: changeGifticon)
        
        addFavoriteGifticon(gifticonUUID: gifticon.uuid)
    }
    
    func didTappedDeleteFavoriteButton(to gifticon: Gifticon) {
        var changeGifticon = gifticon
        changeGifticon.favoriteCount -= 1
        updateGifticonInfo(gifticonUUID: gifticon.uuid, to: changeGifticon)
        
        deleteFavoriteGifticon(gifticonUUID: gifticon.uuid)
    }
    
    private func updateGifticonInfo(gifticonUUID: String, to gifticon: Gifticon) {
        updateGifticonUseCase.execute(gifticonUUID: gifticonUUID, gifticon: gifticon)
    }
    
    private func addFavoriteGifticon(gifticonUUID: String) {
        if let userUID = userUID {
            fetchUserInfoUseCase.execute(with: userUID) { userInfo in
                var changeUserInfo = userInfo
                changeUserInfo.favoriteList.append(gifticonUUID)
                self.updateUserInfoUseCase.execute(userUID: userUID, userInfo: changeUserInfo)
            }
        }
    }
    
    private func deleteFavoriteGifticon(gifticonUUID: String) {
        if let userUID = userUID {
            fetchUserInfoUseCase.execute(with: userUID) { userInfo in
                var changeUserInfo = userInfo
                let changeFavoriteList = userInfo.favoriteList.filter { $0 != gifticonUUID }
                changeUserInfo.favoriteList = changeFavoriteList
                self.updateUserInfoUseCase.execute(userUID: userUID, userInfo: changeUserInfo)
            }
        }
    }
}
