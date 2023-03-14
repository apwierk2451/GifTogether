//
//  Entity.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/09.
//

protocol Entity {
    static var Id: String { get }
    func toDictionary() -> Dictionary<String, Any>
    static func toEntity(dic: [String: Any]) -> Self
}
