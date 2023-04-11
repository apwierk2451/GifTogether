//
//  PaymentPrice.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/20.
//

import SwiftUI

struct PaymentPrice: View {
    var gifticon: Gifticon
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("결제 금액")
                .font(.title2)
                .bold()
                .padding()
            
            Divider()
            
            HStack {
                Text("총 상품 금액")
                    .font(.title3)
                    .padding()
                
                Spacer()
                
                Text("\(gifticon.originalPrice)원")
                    .font(.title3)
                    .bold()
                    .padding()
            }
            .padding(.leading)
            .padding(.trailing)
            
            HStack {
                Text("할인")
                    .font(.title3)
                    .padding()
                
                Spacer()
                
                Text("(-) \(gifticon.discountedPrice)원")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .padding()
            }
            .padding(.leading)
            .padding(.trailing)
            
            Divider()
            
            HStack {
                Text("총 결제 금액")
                    .font(.title)
                    .bold()
                    .padding()
                
                Spacer()
                
                Text("\(gifticon.discountedPrice)원")
                    .font(.title)
                    .bold()
                    .padding()
            }
        }
    }
}

struct PaymentPrice_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        PaymentPrice(gifticon: gifticon)
    }
}
