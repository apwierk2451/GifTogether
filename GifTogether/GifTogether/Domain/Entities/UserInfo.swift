//
//  UserInfo.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/04.
//

import Foundation

struct UserInfo: Entity {
    static let id: String = "userInfo"
    
    let uuid: String
    let name: String
    let email: String
    let phoneNumber: String
    var favoriteList: [String]
    var salesList: [String]
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "uuid": uuid,
            "name": name,
            "email": email,
            "phoneNumber": phoneNumber,
            "favoriteList": favoriteList,
            "salesList": salesList
        ]
    }
    
    static func toEntity(dic: [String : Any]) -> UserInfo {
        guard let uuid = dic["uuid"] as? String,
              let name = dic["name"] as? String,
              let email = dic["email"] as? String,
              let phoneNumber = dic["phoneNumber"] as? String,
              let favoriteList = dic["favoriteList"] as? [String],
              let salesList = dic["salesList"] as? [String] else {
            return .stub()
        }
        
        return UserInfo(uuid: uuid,
                        name: name,
                        email: email,
                        phoneNumber: phoneNumber,
                        favoriteList: favoriteList,
                        salesList: salesList)
    }
}

extension UserInfo {
    
    static func stub(uuid: String = "",
                     name: String = "",
                     email: String = "",
                     phoneNumber: String = "",
                     favoriteList: [String] = [],
                     salesList: [String] = []) -> Self {
        
        .init(uuid: uuid,
              name: name,
              email: email,
              phoneNumber: phoneNumber,
              favoriteList: favoriteList,
              salesList: salesList)
    }
}
