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
            .shadow(radius: 4)
            
            VStack(alignment: .leading) {
                Text(gifticon.brand.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(gifticon.name)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text("\(NumberManager.shared.toDecimal(gifticon.originalPrice) ?? "0")원")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
        }
    }
}

struct GifticonItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GifticonItem(gifticon: gifticon)
    }
}
