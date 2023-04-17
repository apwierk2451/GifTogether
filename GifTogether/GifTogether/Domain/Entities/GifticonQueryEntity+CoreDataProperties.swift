//
//  GifticonQueryEntity+CoreDataProperties.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/30.
//
//

import Foundation
import CoreData


extension GifticonQueryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GifticonQueryEntity> {
        return NSFetchRequest<GifticonQueryEntity>(entityName: "GifticonQueryEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var query: String?

}

extension GifticonQueryEntity : Identifiable {

}
