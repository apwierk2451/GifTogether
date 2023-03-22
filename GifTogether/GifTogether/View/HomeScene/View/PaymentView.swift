//
//  PaymentView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/18.
//

import SwiftUI

struct PaymentView: View {
    var gifticon: Gifticon
    
    var body: some View {
        VStack {
            ScrollView {
                PaymentGifticon(gifticon: gifticon)
                
                ExDivider()
                
                PaymentPrice(gifticon: gifticon)
                
                ExDivider()
            }
            PaymentButton()
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        PaymentView(gifticon: gifticon)
    }
}
