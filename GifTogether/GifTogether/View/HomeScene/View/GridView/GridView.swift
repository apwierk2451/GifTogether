//
//  GridView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct GridView: View {
    var gifticons: [Gifticon] = []
    var body: some View {
        VStack {
            FilterBar(gifticons: gifticons)
struct GridView_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        GridView(gifticons: gifticons)
    }
}
