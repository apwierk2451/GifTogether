//
//  SaleGifticonList.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SaleGifticonList: View {
    var salesList: [Gifticon] = Array(
        repeating: Gifticon.stub(uuid: "123123",
                                 name: "아메리카노",
                                 codeNumber: "123",
                                 brand: .starbucks,
                                 category: .chicken,
                                 originalPrice: "5000",
                                 discountedPrice: "4500",
                                 imageURL: "https://cdn.011st.com/11dims/resize/600x600/quality/75/11src/pd/v2/7/2/3/2/2/3/lgClf/4076723223_B.jpg"),
        count: 9
    )
        
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                
                ForEach(salesList, id: \.uuid) { gifticon in
                    NavigationLink {
                        // TODO: DetailView
                    } label: {
                        SaleItem(gifticon: gifticon)
                    }
                    .padding()
                }
            }
        }
    }
}

struct SaleGifticonList_Previews: PreviewProvider {
    static var previews: some View {
        SaleGifticonList()
    }
}
