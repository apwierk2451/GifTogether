//
//  GridView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct GridView: View {
    @Binding var gifticons: [Gifticon]
    @State var filter: Filter = .마감임박순
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var title: String
    
    var body: some View {
        VStack {
            FilterBar(gifticons: $gifticons, filter: $filter)
                .onChange(of: filter) { filter in
                    sortGifticons(to: filter)
                }
            Divider()
            ScrollView {
                 LazyVGrid(columns: columns) {
                     ForEach(gifticons, id:\.uuid) { gifticon in
                         NavigationLink {
                             DetailView(gifticon: gifticon)
                         } label: {
                             GridGifticon(gifticon: gifticon)
                                 .padding()
                         }
                     }
                 }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func sortGifticons(to filter: Filter) {
        switch filter {
        case .마감임박순:
            self.gifticons.sort {
                return $0.expirationDate < $1.expirationDate
            }
        case .인기순:
            self.gifticons.sort {
                return $0.favoriteCount > $1.favoriteCount
            }
        case .할인율순:
            self.gifticons.sort {
                return $0.discountRate > $1.discountRate
            }
        case .낮은가격순:
            self.gifticons.sort {
                return $0.discountedPrice.toInt() < $1.discountedPrice.toInt()
            }
        case .높은가격순:
            self.gifticons.sort {
                return $0.discountedPrice.toInt() > $1.discountedPrice.toInt()
            }
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        GridView(gifticons: .constant(gifticons), filter: .마감임박순, title: "추천상품")
    }
}
