//
//  Gifticon.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/04.
//

import Foundation

struct Gifticon: Hashable, Identifiable, Codable {
    let id: Int
    let name: String
    let codeNumber: String
    let brand: Brand
    let originalPrice: String
    let discountedPrice: String
    let imageURL: String
    let expirationDate: String
    let provider: UserInfo
    
    enum Brand: String, Codable {
        case starbucks
        case bbq
        
        var name: String {
            switch self {
            case .starbucks:
                return "스타벅스"
            case .bbq:
                return "비비큐"
            }
        }
        var imageURL: String {
            switch self {
            case .starbucks:
                return "스타벅스 브랜드 이미지 url"
            case .bbq:
                return "비비큐 브랜드 이미지 url"
            }
        }
    }
}
