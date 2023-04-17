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
    private let registerGifticonUseCase: RegisterGifticonUseCase
    
    init(
        fetchAllGifticonsUseCase: FetchAllGifticonsUseCase,
        registerGifticonUseCase: RegisterGifticonUseCase
    ) {
        self.fetchAllGifticonsUseCase = fetchAllGifticonsUseCase
        self.registerGifticonUseCase = registerGifticonUseCase
    }
    
    func request() {
        fetchAllGifticonsUseCase.execute { [self] gifticons in
            gifticonsInfo = gifticons
        }
    }
    
    func register(gifticon: Gifticon, _ completion: @escaping () -> Void) {
        registerGifticonUseCase.execute(with: gifticon)
        completion()
    }
}
