//
//  String+.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import Foundation

extension String {
    
    var toDecimal: String? {
        let numberFommater: NumberFormatter = NumberFormatter()
        numberFommater.numberStyle = .decimal
        return numberFommater.string(for: Int(self))
    }
    
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
    
    func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    func isCodeNumber() -> Bool {
        let codeNumberRegEx = "^[0-9]{4} [0-9]{4} [0-9]{4}$"
        let codeNumberTest = NSPredicate(format: "SELF MATCHES %@", codeNumberRegEx)
        return codeNumberTest.evaluate(with: self)
    }
    
    func isDate() -> Bool {
        let dateRegEx = "^2[0-9]{3}[가-힣] [0-1][0-9][가-힣] [0-9]{2}[가-힣]$"
        let dateTest = NSPredicate(format: "SELF MATCHES %@", dateRegEx)
        return dateTest.evaluate(with: self)
    }
    
    func toDate() -> Date? {
        let stringDate = self.replacingOccurrences(of: " ", with: "-").components(separatedBy: ["년", "월", "일"]).joined()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: stringDate)
    }
}
