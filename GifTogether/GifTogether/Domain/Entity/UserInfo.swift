//
//  UserInfo.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/04.
//

import Foundation

struct UserInfo {
    let name: String
    let email: String
    let phoneNumber: String
    let accountInfo: AccountInfo
    
    struct AccountInfo {
        let accountNumber: String
        let bank: Bank
        
        enum Bank {
            case nonghyub
            case hana
        }
    }
}
