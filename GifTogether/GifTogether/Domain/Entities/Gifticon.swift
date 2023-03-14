//
//  Gifticon.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/04.
//

import Foundation

struct Gifticon: Entity {
    static let id: String = "gifticon"
    
    let uuid: String
    let name: String
    let codeNumber: String
    let brand: Brand
    let category: Category
    let originalPrice: String
    let discountedPrice: String
    let imageURL: String
    let expirationDate: String
    let providerUID: String
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "uuid": uuid,
            "name": name,
            "codeNumber": codeNumber,
            "brand": brand.rawValue,
            "category": category.rawValue,
            "originalPrice": originalPrice,
            "discountedPrice": discountedPrice,
            "imageURL": imageURL,
            "expirationDate": expirationDate,
            "providerUID": providerUID
        ]
    }
    
    static func toEntity(dic: [String : Any]) -> Gifticon {
        guard let uuid = dic["uuid"] as? String,
              let name = dic["name"] as? String,
              let codeNumber = dic["codeNumber"] as? String,
              let brand = dic["brand"] as? String,
              let category = dic["category"] as? String,
              let originalPrice = dic["originalPrice"] as? String,
              let discountedPrice = dic["discountedPrice"] as? String,
              let imageURL = dic["imageURL"] as? String,
              let expirationDate = dic["expirationDate"] as? String,
              let providerUID = dic["providerUID"] as? String else {
            
            return .stub()
        }
        
        return Gifticon(uuid: uuid,
                        name: name,
                        codeNumber: codeNumber,
                        brand: Brand(rawValue: brand)!,
                        category: Category(rawValue: category)!,
                        originalPrice: originalPrice,
                        discountedPrice: discountedPrice,
                        imageURL: imageURL,
                        expirationDate: expirationDate,
                        providerUID: providerUID)
    }
    
    enum Brand: String {
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
    
    enum Category: String {
        case coffee
        case food
        case movie
        case iceCream
    }
}

extension Gifticon {
    
    static func stub(uuid: String = "",
                     name: String = "",
                     codeNumber: String = "",
                     brand: Brand = .bbq,
                     category: Category = .coffee,
                     originalPrice: String = "",
                     discountedPrice: String = "",
                     imageURL: String = "",
                     expirationDate: String = "",
                     providerUID: String = "") -> Self {
        .init(uuid: uuid,
              name: name,
              codeNumber: codeNumber,
              brand: brand,
              category: category,
              originalPrice: originalPrice,
              discountedPrice: discountedPrice,
              imageURL: imageURL,
              expirationDate: expirationDate,
              providerUID: providerUID)
    }
}
