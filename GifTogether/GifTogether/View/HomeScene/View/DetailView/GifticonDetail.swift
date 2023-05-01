//
//  GifticonDetail.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/13.
//

import SwiftUI

struct GifticonDetail: View {
    var gifticon: Gifticon
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string: gifticon.imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else if phase.error != nil || phase.image == nil {
                        Image("placeholder")
                            .resizable()
                    } else {
                        ProgressView()
                    }
                } 
                .frame(height: 350)
                .cornerRadius(10)
                
                Text(gifticon.name)
                    .font(.title)
                    .foregroundColor(.black)
                    .bold()
                
                Text(gifticon.brand.name)
                    .foregroundColor(.gray)
                
                Spacer()
                
                priceView
                    .padding()
                    .frame(height: 120)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.red, lineWidth: 1)
                    )
                    .padding()
                
                ExDivider()
            }
            .padding()
        }
    }
    
    
    var priceView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("리셀 상품")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .padding()
            
            HStack(spacing: 20) {
                Text("\(gifticon.discountRate)%")
                    .foregroundColor(.red)
                Text(gifticon.discountedPrice)
                Text(gifticon.originalPrice)
                    .foregroundColor(.gray)
                    .strikethrough()
            }
            .font(.headline)
            .padding()
        }
    }
}

struct GifticonDetail_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GifticonDetail(gifticon: gifticon)
    }
}
