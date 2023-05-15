//
//  SearchViewModel.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation

final class SearchViewModel: ObservableObject {
    
    private let searchGifticonUseCase: SearchGifticonUseCase
    private let searchBrandUseCase: SearchBrandUseCase
    private let fetchRecentGifticonQueriesUseCase: FetchRecentGifticonQueriesUseCase
    private let deleteAllGifticonQueriesUseCase: DeleteAllGifticonQueriesUseCase
    
    @Published var searchedGifticon: [Gifticon] = []
    @Published var searchQueries: [GifticonQuery] = []
    
    init(
        searchGifticonUseCase: SearchGifticonUseCase,
        searchBrandUseCase: SearchBrandUseCase,
        fetchRecentGifticonQueriesUseCase: FetchRecentGifticonQueriesUseCase,
        deleteAllGifticonQueriesUseCase: DeleteAllGifticonQueriesUseCase
    ) {
        self.searchGifticonUseCase = searchGifticonUseCase
        self.searchBrandUseCase = searchBrandUseCase
        self.fetchRecentGifticonQueriesUseCase = fetchRecentGifticonQueriesUseCase
        self.deleteAllGifticonQueriesUseCase = deleteAllGifticonQueriesUseCase
        updateQuery(maxCount: 10)
    }
    
    func search(text: String, maxCount: Int, _ completion: @escaping () -> Void ) {
        searchGifticonUseCase.execute(searchText: text) { [weak self] result in
            switch result {
            case .success(let result):
                self?.searchedGifticon = result
                completion()
            case .failure(let error):
                self?.searchedGifticon = []
                completion()
                print(error.localizedDescription)
            }
        }
    }
    
    func search(brand: Brand, _ completion: @escaping () -> Void) {
        searchBrandUseCase.execute(searchBrand: brand) { [weak self] result in
            switch result {
            case .success(let result):
                self?.searchedGifticon = result
                completion()
            case .failure(let error):
                self?.searchedGifticon = []
                completion()
                print(error.localizedDescription)
            }
        }
    }
    
    func updateQuery(maxCount: Int) {
        fetchRecentGifticonQueriesUseCase.execute(maxCount: maxCount) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let query):
                    self?.searchQueries = query
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func deleteAllGifticonQueries() {
        let allQueriesAreDeleted = deleteAllGifticonQueriesUseCase.execute()
        if allQueriesAreDeleted {
            print("모든 쿼리 삭제 완료")
            updateQuery(maxCount: 10)
        } else {
            print("모든 쿼리 삭제 실패")
        }
    }
}
