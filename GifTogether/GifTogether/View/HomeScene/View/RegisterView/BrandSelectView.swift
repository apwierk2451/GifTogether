//
//  BrandSelectView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/07.
//

import SwiftUI

struct BrandSelectView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var shouldPresent: Bool
    
    var category: Category
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    @State private var searchText = ""
    @State private var shouldShowNextView: Bool = false
    
    var body: some View {
        
        VStack {
            SearchBar(text: $searchText, shouldShowNextView: $shouldShowNextView)
            LazyVGrid(columns: columns) {
                ForEach(category.brand, id: \.name) { brand in
                    if brand.name.hasPrefix(searchText) || searchText.isEmpty {
                        NavigationLink {
                            GifticonRegisterView(shouldPresent: $shouldPresent, category: category, brand: brand)
                                .environmentObject(viewModel)
                        } label: {
                            BrandLogo(brand: brand)
                        }
                    }
                }
            }
            Spacer()
        }
        .navigationTitle("기프티콘 검색")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BrandSelectView_Previews: PreviewProvider {
    static var previews: some View {
        BrandSelectView(shouldPresent: .constant(true), category: .bakery)
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}
