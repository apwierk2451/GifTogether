//
//  GridGifticonItem.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/29.
//

import SwiftUI

struct GridGifticonItem: View {
    var gifticon: Gifticon
    @Binding var isHeart: Bool
    @EnvironmentObject var viewModel: FavoriteViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: gifticon.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else if phase.error != nil || phase.image == nil {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .frame(width: 150, height: 150)
                } else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .cornerRadius(16)
            .overlay {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        Button {
                            if isHeart {
                                viewModel.didTappedDeleteFavoriteButton(to: gifticon)
                            } else {
                                viewModel.didTappedAddFavoriteButton(to: gifticon)
                            }
                            isHeart.toggle()
                            viewModel.fetchFavoriteGifticons()
                        } label: {
                            Image(systemName: isHeart ? "heart.fill" : "heart")
                                .foregroundColor(.pink)
                                .padding(10)
                        }
                    }
                }
            }
            VStack {
                Text(gifticon.brand.name)
                    .foregroundColor(Color("writeColor"))
                Text(gifticon.name)
                    .foregroundColor(Color("writeColor"))
                HStack {
                    Text("\(NumberManager.shared.toDecimal(gifticon.discountedPrice) ?? "0")원")
                        .foregroundColor(Color("writeColor"))
                    Text("\(NumberManager.shared.toDecimal(gifticon.originalPrice) ?? "0")원")
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            }
            .foregroundColor(.black)
        }
    }
}

struct GridGifticonItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GridGifticonItem(gifticon: gifticon, isHeart: .constant(false))
    }
}
