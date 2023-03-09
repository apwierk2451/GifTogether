//
//  APIError.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

enum APIError: LocalizedError {
    case unknown
    case statusCode(Int)
    case badURLRequest
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "알 수 없는 네트워크 오류 발생"
        case .statusCode(let code):
            return "현재 statucCode: \(code) 오류발생"
        case .badURLRequest:
            return "URLRequest가 잘못 되었습니다."
        }
    }
}
