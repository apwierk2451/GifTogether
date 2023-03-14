//
//  CategoryRow.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/12.
//

import SwiftUI

struct CategoryRow: View {
    var items: [Category]

    var body: some View {
        VStack(alignment: .leading) {
            Text("카테고리")
                .font(.title)
                .foregroundColor(.black)
                .bold()
                .padding(.leading, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    
                    ForEach(items, id: \.id) { category in
                        NavigationLink {
                            // DetailView
                        } label: {
                            CategoryItem(category: category)
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var convenience = [Category(id: 0, name: "편의점", imageName: "chicken")]
    
    static var previews: some View {
        CategoryRow(items: convenience)
    }
}
