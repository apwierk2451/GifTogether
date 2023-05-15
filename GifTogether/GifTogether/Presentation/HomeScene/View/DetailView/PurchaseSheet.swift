//
//  PurchaseSheet.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/16.
//

import SwiftUI

struct PurchaseSheet: View {
    var gifticon: Gifticon
    var userInfo: UserInfo
    @Binding var isSheetPresented: Bool
    
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
                .padding()
                Text("결제가격 : \(gifticon.discountedPrice)")
                    .foregroundColor(Color("writeColor"))
                    .padding()
            }
            
            Button("판매자와 SMS 하기") {
                isSheetPresented = false
                let message = "안녕하세요.\nGifTogether 상품 \"\(gifticon.name)\" 확인하고 연락드립니다.\n해당 상품 구매하고 싶어서 연락드립니다!"
                guard let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                      let phoneURL = URL(string: "sms:\(userInfo.phoneNumber)&body=\(encodedMessage)") else { return }
                if UIApplication.shared.canOpenURL(phoneURL) {
                    UIApplication.shared.open(phoneURL)
                }
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
    static var userInfo = UserInfo.stub()
    
    static var previews: some View {
        PurchaseSheet(gifticon: gifticon,
                      userInfo: userInfo,
                      isSheetPresented: .constant(true)
        )
    }
}
