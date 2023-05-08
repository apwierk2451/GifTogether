//
//  Report.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/05/07.
//

import Foundation

struct Report: Entity {
    
    static var id: String = "report"
    
    let uuid: String
    let suspect: String
    let victim: String
    let content: String
    
    func toDictionary() -> Dictionary<String, Any> {
        return [
            "suspect": suspect,
            "victim": victim,
            "content": content
        ]
    }
    
    static func toEntity(dic: [String : Any]) -> Report {
        guard let suspect = dic["suspect"] as? String,
              let victim = dic["victim"] as? String,
              let content = dic["content"] as? String,
              let uuid = dic["uuid"] as? String else {
            return .stub()
        }
        
        return Report(
            uuid: uuid,
            suspect: suspect,
            victim: victim,
            content: content
        )
    }
}

extension Report {
    static func stub() -> Report {
        return .init(
            uuid: "12",
            suspect: "",
            victim: "",
            content: "돈먹고 튀었음."
        )
    }
}
