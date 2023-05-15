//
//  HomeViewModel.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/10.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var gifticonsInfo: [Gifticon] = []
    @Published var recommendGifticon: [Gifticon] = []
    @Published var mostDiscountGifticon: [Gifticon] = []
    
    private let fetchAllGifticonsUseCase: FetchAllGifticonsUseCase
    private let registerGifticonUseCase: RegisterGifticonUseCase
    private let registerImageUseCase: RegisterImageUseCase
    
    init(
        fetchAllGifticonsUseCase: FetchAllGifticonsUseCase,
        registerGifticonUseCase: RegisterGifticonUseCase,
        registerImageUseCase: RegisterImageUseCase
    ) {
        self.fetchAllGifticonsUseCase = fetchAllGifticonsUseCase
        self.registerGifticonUseCase = registerGifticonUseCase
        self.registerImageUseCase = registerImageUseCase
    }
    
    func request() {
        fetchAllGifticonsUseCase.execute { [self] gifticons in
            gifticonsInfo = gifticons
            filteringGifticon()
        }
    }
    
    func fetchImageURL(from data: Data,
                       fileName: String,
                       _ completion: @escaping (URL?) -> Void) {
        
        registerImageUseCase.execute(with: data, fileName: fileName) { imageURL in
            completion(imageURL)
        }
    }
    
    func register(gifticon: Gifticon, _ completion: @escaping () -> Void) {
        registerGifticonUseCase.execute(with: gifticon)
        completion()
    }
    
    private func filteringGifticon() {
        self.recommendGifticon = self.gifticonsInfo.sorted {
            return $0.favoriteCount > $1.favoriteCount
        }
        
        self.mostDiscountGifticon = self.gifticonsInfo.sorted {
            return $0.discountRate > $1.discountRate
        }
    }
}
