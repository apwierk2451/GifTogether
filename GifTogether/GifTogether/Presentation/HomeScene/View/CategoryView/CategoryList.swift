//
//  CategoryList.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/20.
//

import SwiftUI

extension Animation {
    static func ripple() -> Animation {
        Animation.spring(dampingFraction: 0.7)
            .speed(2)
    }
}

struct CategoryList: View {
    
    @Binding var category: Category
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    VStack() {
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(Category.allCases, id: \.title) { category in
                                Button(category.title) {
                                    self.category = category
                                    withAnimation {
                                        proxy.scrollTo(category.title, anchor: .center)
                                    }
                                }
                                .id(category.title)
                                .frame(height: 25)
                                .foregroundColor(self.category == category ? Color(.label) : Color(.secondaryLabel))
                            }
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        
                        CategoryIndicator(category: $category)
                            .offset(x: category.layout.xPosition)
                            .animation(.ripple(),
                                       value: category.layout.xPosition)
                    }
                }
                .onAppear {
                    withAnimation {
                        proxy.scrollTo(category.title)
                    }
                }
            }
        }
    }
}

struct CategoryList_Previews: PreviewProvider {
    @State static var category = Category.mart
    static var previews: some View {
        CategoryList(category: $category)
    }
}
