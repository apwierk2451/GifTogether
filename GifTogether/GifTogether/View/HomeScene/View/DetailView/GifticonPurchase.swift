//
//  GifticonPurchase.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/16.
//

import SwiftUI

struct GifticonPurchase: View {
    var gifticon: Gifticon
    @State private var shouldShowSheetPresent = false
    @State private var shouldShowPaymentPresent = false
    @State var favoriteCount: Int = 0
    @State var isHeart: Bool = true
    @EnvironmentObject var viewModel: FavoriteViewModel
    
    var body: some View {
        HStack {
            Button {
                if isHeart {
                    favoriteCount -= 1
                    var changeGifticon = gifticon
                    changeGifticon.favoriteCount = favoriteCount
                    viewModel.updateGifticonInfo(gifticonUUID: gifticon.uuid, to: changeGifticon)
                    
                    viewModel.deleteFavoriteGifticon(gifticonUUID: gifticon.uuid)
                } else {
                    favoriteCount += 1
                    var changeGifticon = gifticon
                    changeGifticon.favoriteCount = favoriteCount
                    viewModel.updateGifticonInfo(gifticonUUID: gifticon.uuid, to: changeGifticon)
                    
                    viewModel.addFavoriteGifticon(gifticonUUID: gifticon.uuid)
                }
                isHeart.toggle()
            } label: {
                VStack {
                    Image(systemName: isHeart ? "heart.fill" : "heart")
                    Text("\(favoriteCount)")
                }
            }
            .foregroundColor(.red)
            .frame(height: 20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .onAppear {
                viewModel.checkFavortieGifticon(uuid: gifticon.uuid) { isHeart in
                    self.isHeart = isHeart
                }
                favoriteCount = gifticon.favoriteCount
                viewModel.fetchGifticonInfo(gifticonUUID: gifticon.uuid) { gifticon in
                    favoriteCount = gifticon.favoriteCount
                }
            }
            
            Button {
                self.shouldShowSheetPresent.toggle()
            } label: {
                Text("구매하기")
                    .foregroundColor(.white)
                    .frame(height: 20)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(15)
            }
            .halfSheet(showSheet: self.$shouldShowSheetPresent, sheetView: {
                PurchaseSheet(gifticon: gifticon,
                              isSheetPresented: $shouldShowSheetPresent,
                              isPaymentPresented: $shouldShowPaymentPresent
                )
            })
        }
        .padding()
        
        NavigationLink(destination: PaymentView(gifticon: gifticon),
                       isActive: self.$shouldShowPaymentPresent) {
            EmptyView()
        }.hidden()
    }
}

struct GifticonPurchase_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        GifticonPurchase(gifticon: gifticon)
    }
}
