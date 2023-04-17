//
//  MyPageViewModel.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//
import Foundation
import Combine

final class MyPageViewModel: ObservableObject {
    private let fetchUserInfoUseCase: FetchUseInfoUseCase
    private let fetchGifticonUseCase: FetchGifticonUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    
    @Published var userInfo: UserInfo = .stub()
    @Published var salesList: [Gifticon] = []
    
    init(
        fetchUserInfoUseCase: FetchUseInfoUseCase,
        fetchGifticonUseCase: FetchGifticonUseCase,
        deleteAccountUseCase: DeleteAccountUseCase
    ) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.fetchGifticonUseCase = fetchGifticonUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
    }
    
    private func fetchSalesList(with uuidList: [String]) {
        guard uuidList.isEmpty == false else { return }
        for uuid in uuidList {
            fetchGifticonUseCase.execute(uuid: uuid) { [weak self] gifticon in
                guard let gifticon = gifticon,
                        self?.salesList.contains(where: { element in
                    element.uuid == gifticon.uuid }) == false else { return }
                self?.salesList.append(gifticon)
            }
        }
    }
    
    func fetchUserInfo() {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        fetchUserInfoUseCase.execute(with: userUID) { [weak self] userInfo in
            if let userInfo = userInfo {
                self?.userInfo = userInfo
                self?.fetchSalesList(with: userInfo.salesList)
            }
        }
    }
    
    func deleteAccount(_ completion: @escaping () -> Void) {
        deleteAccountUseCase.execute { result in
            if result == true {
                completion()
            }
        }
    }
}
