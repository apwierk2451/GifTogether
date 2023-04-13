//
//  DateManager.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/10.
//

import Foundation

final class DateManager {
    static let shared = DateManager()
    private let dateFormatter = DateFormatter()
    
    private init() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func toString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
