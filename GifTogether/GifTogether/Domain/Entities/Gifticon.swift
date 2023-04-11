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
    var favoriteCount: Int
    
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
            "providerUID": providerUID,
            "favoriteCount": favoriteCount
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
              let providerUID = dic["providerUID"] as? String,
              let favoriteCount = dic["favoriteCount"] as? Int else {
            
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
                        providerUID: providerUID,
                        favoriteCount: favoriteCount)
    }
}


extension Gifticon {
    
    static func stub(uuid: String = "",
                     name: String = "",
                     codeNumber: String = "",
                     brand: Brand = .kyochon,
                     category: Category = .chicken,
                     originalPrice: String = "",
                     discountedPrice: String = "",
                     imageURL: String = "",
                     expirationDate: String = "",
                     providerUID: String = "",
                     favoriteCount: Int = 0) -> Self {
        .init(uuid: uuid,
              name: name,
              codeNumber: codeNumber,
              brand: brand,
              category: category,
              originalPrice: originalPrice,
              discountedPrice: discountedPrice,
              imageURL: imageURL,
              expirationDate: expirationDate,
              providerUID: providerUID,
              favoriteCount: favoriteCount)
    }
}
