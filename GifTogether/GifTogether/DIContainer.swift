//
//  DIContainer.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import Foundation

final class DIContainer {
    
    // MARK: - Persistent Storage
    lazy var gifticonQueriesStorage: GifticonQueriesStorage = CoreDataGifticonQueriesStorage(
        maxStorageLimit: 10
    )
    
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
        return MyPageViewModel(
            fetchUserInfoUseCase: makeFetchUserInfoUseCase(),
            deleteAccountUseCase: makeDeleteAccountUseCase()
        )
    }
    
    // MARK: - Search ViewModel
    func makeSearchViewModel() -> SearchViewModel {
        return SearchViewModel(
            searchGifticonUseCase: makeSearchGifticonUseCase(),
            fetchRecentGifticonQueriesUseCase: makeFetchRecentGifticonQueriesUseCase(),
            deleteAllGifticonQueriesUseCase: makeDeleteAllGifticonQueriesUseCase()
        )
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
    
    func makeSearchGifticonUseCase() -> SearchGifticonUseCase {
        return DefaultSearchGifticonUseCase(
            gifticonRepository: makeGifticonRepository(),
            gifticonQueriesRepository: makeGifticonQueriesRepository()
        )
    }
    
    func makeFetchRecentGifticonQueriesUseCase() -> FetchRecentGifticonQueriesUseCase {
        return DefaultFetchRecentGifticonQueriesUseCase(
            gifticonQueriesRepository: makeGifticonQueriesRepository()
        )
    }
    
    func makeDeleteAllGifticonQueriesUseCase() -> DeleteAllGifticonQueriesUseCase {
        return DefaultDeleteAllGifticonQueriesUseCase(
            gifticonQueriesRepository: makeGifticonQueriesRepository()
        )
    }
    
    func makeDeleteAccountUseCase() -> DeleteAccountUseCase {
        return DefaultDeleteAccountUseCase(
            firebaseAuthService: makeFirebaseAuthService(),
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
    
    func makeGifticonQueriesRepository() -> GifticonQueriesRepository {
        return DefaultGifticonQueriesRepository(
            gifticonQueriesPersistentStorage: gifticonQueriesStorage
        )
    }
}
