//
//  GifticonQueryEntity+Mapping.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//

import Foundation
import CoreData

extension GifticonQueryEntity {
    convenience init(
        gifticonQuery: GifticonQuery,
        insertInto context: NSManagedObjectContext
    ) {
        self.init(context: context)
        query = gifticonQuery.query
        createdAt = Date()
    }
}

extension GifticonQueryEntity {
    func toDomain() -> GifticonQuery {
        return .init(query: query ?? "")
    }
}
