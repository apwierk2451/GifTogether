//
//  GifticonItem.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct GifticonItem: View {
    var gifticon: Gifticon
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: gifticon.imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .shadow(radius: 10)
            
            VStack(alignment: .leading) {
                Text(gifticon.brand.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(gifticon.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text("\(gifticon.originalPrice)원")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}

struct GifticonItem_Previews: PreviewProvider {
    static var gifticon = Gifticon(id: 0, name: "뿌링클 촉촉", codeNumber: "123", brand: .bbq, originalPrice: "20000", discountedPrice: "18000", imageURL: "https://user-images.githubusercontent.com/95114036/224054115-ce17b5e6-9c8e-4964-b212-b8fee0a5ecb5.jpeg", expirationDate: "", provider: .init(name: "", email: "", phoneNumber: "", accountInfo: .init(accountNumber: "", bank: .hana)))
    
    static var previews: some View {
        GifticonItem(gifticon: gifticon)
    }
}
