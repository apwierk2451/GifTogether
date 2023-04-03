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
    
    var body: some View {
        HStack {
            Button {
                // TODO: 기프티콘 찜 개수 + 1
            } label: {
                VStack {
                    Image(systemName: "heart")
                    Text("23")
                }
            }
            .foregroundColor(.gray)
            .frame(height: 20)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray, lineWidth: 1)
            )
            
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
