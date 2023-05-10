//
//  CategoryItem.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/12.
//

import SwiftUI

struct CategoryItem: View {
    var category: Category
    
    var body: some View {
        VStack {
            Image(category.imageName)
                .resizable()
                .clipShape(Circle())
                .frame(width: 70, height: 70)
                .shadow(radius: 10)
            
            VStack {
                Text(category.title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("writeColor"))
            }
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var category = Category.mart
    
    static var previews: some View {
        CategoryItem(category: category)
    }
}
