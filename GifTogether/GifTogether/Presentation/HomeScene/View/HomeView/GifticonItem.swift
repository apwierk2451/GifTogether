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
            AsyncImage(url: URL(string: gifticon.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil || phase.image == nil {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
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
                    .foregroundColor(Color("writeColor"))
                    .lineLimit(2)
                Text("\(NumberManager.shared.toDecimal(gifticon.originalPrice) ?? "0")원")
                    .font(.subheadline)
                    .foregroundColor(Color("writeColor"))
            }
            .frame(width: UIScreen.main.bounds.width / 3)
        }
    }
}

struct GifticonItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub(name: "떠먹는 티라미수 + 아메리카노 (R) 2잔", originalPrice: "15500")
    
    static var previews: some View {
        GifticonItem(gifticon: gifticon)
    }
}
