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
                    NavigationLink {
                        GridTestView(isFromCategoryView: true,
                                     passedBrand: brand,
                                     title: brand.name)
                            .environmentObject(DIContainer().makeSearchViewModel())
                        // TODO: searchViewModel이 추가적으로 사용되고 있다..
                    } label: {
                        BrandLogo(brand: brand)
                    }
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
