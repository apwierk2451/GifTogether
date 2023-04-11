//
//  PaymentGifticon.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/20.
//

import SwiftUI

struct PaymentGifticon: View {
    var gifticon: Gifticon
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: gifticon.imageURL)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 150)
            .cornerRadius(16)
            .padding()
            
            VStack(alignment: .leading) {
                Text(gifticon.name)
                    .font(.title)
                    .bold()
                
                Text(gifticon.brand.rawValue)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                Text(gifticon.originalPrice)
                    .foregroundColor(.gray)
                    .strikethrough()
                
                HStack {
                    Text("\(50)%")
                        .foregroundColor(.red)
                    
                    Text("\(gifticon.discountedPrice)원")
                }
                .padding(.top)
            }
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
        .shadow(radius: 10)
        .padding()
        Text("유효기간 \(gifticon.expirationDate) 까지")
    }
}

struct PaymentGifticon_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        PaymentGifticon(gifticon: gifticon)
    }
}
