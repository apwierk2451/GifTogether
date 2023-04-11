//
//  HomeViewModel.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/10.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var gifticonsInfo: [Gifticon] = []
    
    private let fetchAllGifticonsUseCase: FetchAllGifticonsUseCase
    
    init(fetchAllGifticonsUseCase: FetchAllGifticonsUseCase) {
        self.fetchAllGifticonsUseCase = fetchAllGifticonsUseCase
    }
    
    func request() {
        fetchAllGifticonsUseCase.execute { [self] gifticons in
            gifticonsInfo = gifticons
        }
    }
}
