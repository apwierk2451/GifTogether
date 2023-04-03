//
//  GridGifticon.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct GridGifticon: View {
    var gifticon: Gifticon
    @State var isHeart: Bool
    
    var body: some View {
        Rectangle()
            .frame(width: 150, height: 200)
            .foregroundColor(.white)
            .cornerRadius(16)
            .shadow(radius: 16)
            .overlay {
                GridGifticonItem(gifticon: gifticon, isHeart: $isHeart)
            }
    }
}

struct GridItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GridGifticon(gifticon: gifticon, isHeart: false)
    }
}
