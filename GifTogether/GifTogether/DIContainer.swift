//
//  DIContainer.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import Foundation

final class DIContainer {
    
    // MARK: - Login ViewModel
    func makeLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            loginUseCase: makeLoginUseCase(),
            createUserUseCase: makeCreateUserUseCase()
        )
    }
    
    // MARK: - Home ViewModel
    func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(searchGifticonUseCase: makeSearchGifticonUseCase())
    }
    
    // MARK: - MyPage ViewModel
    func makeMyPageViewModel() -> MyPageViewModel {
        return MyPageViewModel(fetchUserInfoUseCase: makeFetchUserInfoUseCase())
    }
    
    
    // MARK: - UseCases
    func makeLoginUseCase() -> LoginUseCase {
        return DefaultLoginUseCase(firebaseAuthService: makeFirebaseAuthService())
    }
    
    func makeCreateUserUseCase() -> CreateUserUseCase {
        return DefaultCreateUserUseCase(
            firebaseAuthService: makeFirebaseAuthService(),
            firestoreService: makeUserInfoRepository()
        )
    }
    
    func makeSearchGifticonUseCase() -> SearchGifticonListUseCase {
        return DefaultSearchGifticonListUseCase(
            gifticonRepository: makeGifticonRepository()
        )
    }
    
    func makeFetchUserInfoUseCase() -> FetchUseInfoUseCase {
        return DefaultFetchUseInfoUseCase(
            userInfoRepository: makeUserInfoRepository()
        )
    }
    
    // MARK: - Data
    func makeFirebaseAuthService() -> DefaultFirebaseAuthService {
        return DefaultFirebaseAuthService()
    }
    
    func makeUserInfoRepository() -> UserInfoRepository {
        return UserInfoRepository()
    }
    
    func makeGifticonRepository() -> GifticonRepository {
        return GifticonRepository()
    }
}
