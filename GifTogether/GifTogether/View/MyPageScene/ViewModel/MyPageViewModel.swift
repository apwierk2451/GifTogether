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
    private let deleteAccountUseCase: DeleteAccountUseCase
    
    @Published var userInfo: UserInfo = .stub()
    
    init(
        fetchUserInfoUseCase: FetchUseInfoUseCase,
        deleteAccountUseCase: DeleteAccountUseCase
    ) {
        self.fetchUserInfoUseCase = fetchUserInfoUseCase
        self.deleteAccountUseCase = deleteAccountUseCase
    }
    
    func fetchUserInfo() {
        guard let userUID = UserDefaults.standard.object(forKey: "userUID") as? String else {
            return
        }
        fetchUserInfoUseCase.execute(with: userUID) { userInfo in
            self.userInfo = userInfo
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
