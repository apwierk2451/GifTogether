//
//  CategoryView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/22.
//

import SwiftUI

struct CategoryView: View {
    @State var category: Category
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        VStack {
            CategoryList(category: $category)
            LazyVGrid(columns: columns) {
                ForEach(category.brand, id: \.name) { brand in
                    BrandLogo(brand: brand)
                    // TODO: Brand의 상품들을 보여주는 GridView로 이동하는 NavigationLink연결
                }
            }
            Spacer()
        }
        .background(Color(uiColor: .secondarySystemBackground))
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView(category: .mart)
    }
}
