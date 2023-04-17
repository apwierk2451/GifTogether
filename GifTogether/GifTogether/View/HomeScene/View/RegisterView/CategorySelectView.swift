//
//  CategorySelectView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/07.
//

import SwiftUI

struct CategorySelectView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var shouldPresent: Bool
    
    var columns = [
        GridItem(spacing: 0),
        GridItem(spacing: 0),
        GridItem(spacing: 0)
    ]
    
    var body: some View {
        
        NavigationView {
            VStack {
                LazyVGrid(columns: columns) {
                    ForEach(Category.allCases, id: \.title) { category in
                        NavigationLink {
                            BrandSelectView(shouldPresent: $shouldPresent, category: category)
                        } label: {
                            Rectangle()
                                .frame(width: UIScreen.main.bounds.maxX / 3 - 20, height: 100)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay {
                                    Text(category.title)
                                        .foregroundColor(.black)
                                }
                        }
                    }
                }
                .navigationTitle("카테고리")
                .navigationBarTitleDisplayMode(.inline)
                
                Text("등록할 기프티콘의 카테고리를 선택해주세요.")
                    .foregroundColor(.secondary)
                    .padding()
                
                Spacer()
            }
            .background(Color(uiColor: .systemGray4))
        }
    }
}

struct CategorySelectView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectView(shouldPresent: .constant(true))
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}

