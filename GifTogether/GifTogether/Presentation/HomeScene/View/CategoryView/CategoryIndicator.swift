//
//  CategoryIndicator.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/20.
//

import SwiftUI

struct CategoryIndicator: View {
    @Binding var category: Category
    
    var body: some View {
        Capsule(style: .circular)
            .frame(width: category.layout.width, height: 5)
    }
}

struct CategoryIndicator_Previews: PreviewProvider {
    static var previews: some View {
        CategoryIndicator(category: .constant(.cafeDissert))
    }
}
