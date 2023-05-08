//
//  PurchaseSheet.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/16.
//

import SwiftUI

struct PurchaseSheet: View {
    var gifticon: Gifticon
    @Binding var isSheetPresented: Bool
    @Binding var isPaymentPresented: Bool
    
    var body: some View {
        VStack {
            Text("주문하실 기프티콘을 확인해주세요")
                .font(.title2)
                .bold()
            HStack {
                VStack {
                    Text("\(gifticon.brand.rawValue)")
                        .foregroundColor(.gray)
                    Text("\(gifticon.name)")
                }
                Text("결제가격 : \(gifticon.discountedPrice)")
                    .padding()
            }
            
            Button("결제하기") {
                isSheetPresented = false
                isPaymentPresented.toggle()
            }
            .foregroundColor(.white)
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .cornerRadius(15)
            .padding()
        }
    }
}

struct PurchaseSheet_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        PurchaseSheet(gifticon: gifticon,
                      isSheetPresented: .constant(true),
                      isPaymentPresented: .constant(true)
        )
    }
}
