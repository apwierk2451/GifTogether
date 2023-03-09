//
//  APIConfiguration.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation

struct APIConfiguration {
    let url: String
    
    func makeURLRequest() -> URLRequest? {
        
        guard let url = URL(string: url) else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        return urlRequest
    }
}
