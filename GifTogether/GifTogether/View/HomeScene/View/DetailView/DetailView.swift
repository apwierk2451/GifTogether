//
//  DetailView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/13.
//

import SwiftUI

struct DetailView: View {
    var gifticon: Gifticon
    var favoriteViewModel = DIContainer().makeFavoriteViewModel()
    var body: some View {
        VStack {
            ScrollView {
                GifticonDetail(gifticon: gifticon)
                    .listRowInsets(EdgeInsets())
            }
            GifticonPurchase(gifticon: gifticon)
                .environmentObject(favoriteViewModel)
                .navigationTitle("상세보기")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        DetailView(gifticon: gifticon)
    }
}
