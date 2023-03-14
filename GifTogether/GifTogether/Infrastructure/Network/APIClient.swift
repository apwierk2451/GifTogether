//
//  APIClient.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Foundation
import Combine

struct APIClient {
    static let shared = APIClient(sesseion: URLSession.shared)
    private let session: URLSessionProtocol
    
    init(sesseion: URLSessionProtocol) {
        self.session = sesseion
    }

    func requestData<T: Decodable>(with urlRequest: URLRequest,
                                   type: T.Type) -> AnyPublisher<T, APIError> {
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.statusCode(httpResponse.statusCode)
                }
                return data
            }
            .decode(type: type, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - URLSessionProtocol
protocol URLSessionProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLSessionProtocol {}
