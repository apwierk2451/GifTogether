//
//  SaleGifticonList.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SaleGifticonList: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 10) {
                
                ForEach(viewModel.salesList, id: \.uuid) { gifticon in
                    NavigationLink {
                        DetailView(gifticon: gifticon)
                    } label: {
                        SaleItem(gifticon: gifticon)
                    }
                    .padding()
                }
            }
        }
    }
}

struct SaleGifticonList_Previews: PreviewProvider {
    static var previews: some View {
        SaleGifticonList()
            .environmentObject(DIContainer().makeMyPageViewModel())
    }
}
