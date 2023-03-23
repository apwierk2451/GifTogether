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
    
    @Published var userInfo: UserInfo = .stub()
    
    init(fetchUserInfoUseCase: FetchUseInfoUseCase) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
    }
    
    func fetchUserInfo() {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        fetchUserInfoUseCase.execute(with: userUID) { userInfo in
            self.userInfo = userInfo
        }
    }
}
