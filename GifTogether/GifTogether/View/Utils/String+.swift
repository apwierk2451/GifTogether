//
//  String+.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+_]+@[A-Z0-9a-z.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidPhoneNumber() -> Bool {
        let phoneNumberRegEx = "^01[0-1, 7][0-9]{7,8}$"
        let phoneNumberTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegEx)
        return phoneNumberTest.evaluate(with: self)
    }
    
    func isValidNickName() -> Bool {
        if self.count >= 1 && self.count <= 20 {
            return true
        } else {
            return false
        }
    }
    
    func isValidPassword() -> Bool {
        if self.count >= 8 && self.count <= 20 {
            return true
        } else {
            return false
        }
    }
}
