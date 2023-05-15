//
//  NumberManager.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/26.
//

import Foundation

final class NumberManager {
    static let shared = NumberManager()

    private let numberFormatter: NumberFormatter

    private init() {
        numberFormatter = NumberFormatter()
    }

    func toDecimal(_ number: String) -> String? {
        
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(for: Int(number))
    }
}
