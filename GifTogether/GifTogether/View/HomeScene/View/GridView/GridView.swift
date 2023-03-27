//
//  GridView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct GridView: View {
    var gifticons: [Gifticon]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var title: String
    var body: some View {
        VStack {
            FilterBar(gifticons: gifticons)
            
            Divider()
            ScrollView {
                 LazyVGrid(columns: columns) {
                     ForEach(gifticons, id:\.uuid) { gifticon in
                         NavigationLink {
                             DetailView(gifticon: gifticon)
                         } label: {
                             GridGifticon(gifticon: gifticon, isHeart: true)
                                 .padding()
                         }
                     }
                 }
            }
            .navigationTitle(title)
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        GridView(gifticons: gifticons, title: "추천상품")
    }
}
