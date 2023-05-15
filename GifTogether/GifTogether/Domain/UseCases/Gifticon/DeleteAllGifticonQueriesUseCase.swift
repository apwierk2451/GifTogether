//
//  DeleteAllGifticonQueriesUseCase.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/03.
//

import Foundation

protocol DeleteAllGifticonQueriesUseCase {
    func execute() -> Bool
}

struct DefaultDeleteAllGifticonQueriesUseCase: DeleteAllGifticonQueriesUseCase {
    
    let gifticonQueriesRepository: GifticonQueriesRepository
    
    func execute() -> Bool {
        gifticonQueriesRepository.deleteAll()
    }
}
