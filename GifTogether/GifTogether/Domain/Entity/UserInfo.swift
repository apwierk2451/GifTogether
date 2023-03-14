//
//  UserInfo.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/04.
//

import Foundation

struct UserInfo: Hashable, Codable {
    let name: String
    let email: String
    let phoneNumber: String
    let accountInfo: AccountInfo
    
    struct AccountInfo: Hashable, Codable {
        let accountNumber: String
        let bank: Bank
        
        enum Bank: String, Codable {
            case nonghyub
            case hana
        }
    }
}
