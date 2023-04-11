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
    private let searchGifticonUseCase: SearchGifticonListUseCase
    private let updateUserInfoUseCase: UpdateUserInfoUseCase
    private let updateGifticonUseCase: UpdateGifticonUseCase
    
    @Published var filteredGifticons: [Gifticon] = []
    
    init(
        fetchUserInfoUseCase: FetchUseInfoUseCase,
        searchGifticonUseCase: SearchGifticonListUseCase,
        updateUserInfoUseCase: UpdateUserInfoUseCase,
        updateGifticonUseCase: UpdateGifticonUseCase
    ) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.searchGifticonUseCase = searchGifticonUseCase
        self.updateUserInfoUseCase = updateUserInfoUseCase
        self.updateGifticonUseCase = updateGifticonUseCase
    }
    
    func fetchUserInfo() {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        filteredGifticons = []
        fetchUserInfoUseCase.execute(with: userUID) { userInfo in
            self.searchGifticonUseCase.execute { [weak self] gifticons in
                gifticons.forEach { gifticon in
                    if userInfo.favoriteList.contains(gifticon.uuid) {
                        self?.filteredGifticons.append(gifticon)
                    }
                }
            }
        }
    }
    
    func addFavoriteGifticon(gifticonUUID: String) {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        fetchUserInfoUseCase.execute(with: userUID) { userInfo in
            var changeUserInfo = userInfo
            changeUserInfo.favoriteList.append(gifticonUUID)
            self.updateUserInfoUseCase.execute(userUID: userUID, userInfo: changeUserInfo)
        }
    }
    
    func deleteFavoriteGifticon(gifticonUUID: String) {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        fetchUserInfoUseCase.execute(with: userUID) { userInfo in
            var changeUserInfo = userInfo
            let changeFavoriteList = userInfo.favoriteList.filter { $0 != gifticonUUID }
            changeUserInfo.favoriteList = changeFavoriteList
            self.updateUserInfoUseCase.execute(userUID: userUID, userInfo: changeUserInfo)
        }
    }
    
    func checkFavortieGifticon(uuid: String, completion: @escaping (Bool) -> Void) {
        if let userUID = UserDefaults.standard.object(forKey: "userUID") as? String {
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
        searchGifticonUseCase.execute { gifticons in
            let gifticonInfo = gifticons.filter { $0.uuid == gifticonUUID }
            completion(gifticonInfo[0])
        }
    }
    
    func updateGifticonInfo(gifticonUUID: String, to gifticon: Gifticon) {
        updateGifticonUseCase.execute(gifticonUUID: gifticonUUID, gifticon: gifticon)
    }
}
