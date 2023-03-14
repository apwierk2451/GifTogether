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
                Text(category.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
            }
        }
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var category = Category(id: 0, name: "편의점", imageName: "chicken")
    
    static var previews: some View {
        CategoryItem(category: category)
    }
}
