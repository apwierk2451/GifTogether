//
//  HomeViewModel.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/10.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var gifticonsInfo: [Gifticon] = []
    
    private let searchGifticonUseCase: SearchGifticonListUseCase
    
    init(searchGifticonUseCase: SearchGifticonListUseCase) {
        self.searchGifticonUseCase = searchGifticonUseCase
    }
    
    func request() {
        searchGifticonUseCase.execute { [self] gifticons in
            gifticonsInfo = gifticons
        }
    }
}
