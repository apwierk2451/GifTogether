//
//  SaleGifticonList.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SaleGifticonList: View {
    var salesList: [Gifticon]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                
                ForEach(salesList, id: \.uuid) { gifticon in
                    NavigationLink {
                        // TODO: 삭제/수정을 수행할 수 있는 메뉴 보이도록 DetailView 설정
                        DetailView(gifticon: gifticon)
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
        SaleGifticonList(
            salesList: [.stub(uuid: "", name: "테스트", codeNumber: "123",
                              brand: .bbq, category: .bakery, originalPrice: "200",
                              discountedPrice: "130", imageURL: "",
                              expirationDate: "2022-12-12", providerUID: "",
                              favoriteCount: 2)])
    }
}
