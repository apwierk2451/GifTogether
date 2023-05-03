//
//  FilterBar.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct FilterBar: View {
    @Binding var gifticons: [Gifticon]
    @Binding var filter: Filter
    @State private var shouldShowSheetPresent = false
    
    var body: some View {
        HStack {
            Text("\(gifticons.count)개의 상품")
            
            Spacer()
            
            Button {
                self.shouldShowSheetPresent = true
            } label: {
                Text("\(filter.rawValue)")
                
                Image(systemName: "slider.vertical.3")
                    .rotationEffect(Angle(degrees: 270))
            }
            .foregroundColor(.black)
            .halfSheet(showSheet: $shouldShowSheetPresent) {
                filterSheet
            } onDismiss: {
                self.shouldShowSheetPresent = false
            }
        }
        .padding()
    }
    
    var filterSheet: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 20)
                
                ForEach(Filter.allCases, id: \.self) { filter in
                    Button {
                        self.filter = filter
                        self.shouldShowSheetPresent = false
                    } label: {
                        Text("\(filter.rawValue)")
                            .padding()
                    }
                    Divider()
                }
            }
            .foregroundColor(.black)
        }
    }
}

struct FilterBar_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        FilterBar(gifticons: .constant(gifticons), filter: .constant(.마감임박순))
    }
}

enum Filter: String, CaseIterable {
    case 마감임박순
    case 인기순
    case 할인율순
    case 낮은가격순
    case 높은가격순
}
