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

struct GridGifticonItem_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GridGifticonItem(gifticon: gifticon, isHeart: .constant(false))
    }
}
