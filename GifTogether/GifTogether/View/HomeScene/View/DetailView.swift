//
//  DetailView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/13.
//

import SwiftUI

struct DetailView: View {
    var gifticon: Gifticon
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    GifticonDetail(gifticon: gifticon)
                        .listRowInsets(EdgeInsets())
                }
                GifticonPurchase(gifticon: gifticon)
                    .navigationTitle("상세보기")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        DetailView(gifticon: gifticon)
    }
}
