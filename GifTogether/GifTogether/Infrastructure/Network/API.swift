//
//  API.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

import Combine

protocol API {
    associatedtype ResponseType: Decodable
    var configuration: APIConfiguration? { get }
}

extension API {
    
    func execute(using client: APIClient = APIClient.shared) -> AnyPublisher<ResponseType, APIError> {
        
        guard let urlRequest = configuration?.makeURLRequest() else {
            return Fail(error: .badURLRequest).eraseToAnyPublisher()
        }
        return client.requestData(with: urlRequest, type: ResponseType.self)
    }
}
