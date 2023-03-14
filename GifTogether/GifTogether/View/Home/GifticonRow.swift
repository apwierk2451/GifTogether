//
//  GifticonRow.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct GifticonRow: View {
    var categoryName: String
    var items: [Gifticon]

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
               
                NavigationLink {
                    // CategoryView
                } label: {
                    Text(categoryName)
                        .font(.title)
                        .foregroundColor(.black)
                        .bold()
                        .padding(.leading, 15)
                    
                }
                .padding()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 10) {
                    
                    ForEach(items) { gifticon in
                        NavigationLink {
                            // DetailView
                        } label: {
                            GifticonItem(gifticon: gifticon)
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct GifticonRow_Previews: PreviewProvider {
    static var gifticons = [Gifticon(id: 0, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana))), Gifticon(id: 1, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana))), Gifticon(id: 2, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana))), Gifticon(id: 3, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana))), Gifticon(id: 4, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana))), Gifticon(id: 5, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana)))]
    
    static var previews: some View {
        GifticonRow(
            categoryName: "추천상품",
            items: gifticons
        )
    }
}
