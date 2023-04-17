//
//  CategoryView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/22.
//

import SwiftUI

struct CategoryView: View {
    private let viewModel = DIContainer().makeSearchViewModel()
    @State var category: Category
    @State private var brandName: String = ""
    @State private var shouldShowNextView: Bool = false
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        NavigationLink(isActive: $shouldShowNextView) {
            GridView(gifticons: viewModel.searchedGifticon, title: brandName)
        } label: {
            EmptyView()
        }
        VStack {
            CategoryList(category: $category)
            LazyVGrid(columns: columns) {
                ForEach(category.brand, id: \.name) { brand in
                    BrandLogo(brand: brand)
                        .onTapGesture {
                            viewModel.search(brand: brand) {
                                brandName = brand.name
                                shouldShowNextView = true
                            }
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
