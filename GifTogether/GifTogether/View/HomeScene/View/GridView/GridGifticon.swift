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
                VStack {
                    AsyncImage(url: URL(string: gifticon.imageURL)) { image in
                            image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 100, height: 100)
                    .cornerRadius(16)
                    .overlay {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                
                                Button {
                                    isHeart.toggle()
                                } label: {
                                    Image(systemName: isHeart ? "heart" : "heart.fill")
                                        .foregroundColor(.pink)
                                        .padding(10)
                                }
                            }
                        }
                    }
                    VStack {
                        Text(gifticon.brand.name)
                        Text(gifticon.name)
                        HStack {
                            Text("\(gifticon.discountedPrice)원")
                            Text("\(gifticon.originalPrice)원")
                                .foregroundColor(.gray)
                                .strikethrough()
                        }
                    }
                    .foregroundColor(.black)
                }
            }
        
    }
}

struct GridItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GridGifticon(gifticon: gifticon, isHeart: true)
    }
}
