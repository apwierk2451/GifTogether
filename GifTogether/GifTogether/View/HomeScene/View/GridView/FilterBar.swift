//
//  FilterBar.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/22.
//

import SwiftUI

struct FilterBar: View {
    var gifticons: [Gifticon]
    @State private var filter: Filter = .최신순
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
            .sheet(isPresented: self.$shouldShowSheetPresent) {
                filterSheet
                // TODO: sheet height를 중간으로 지정하기
            }
        }
        .padding()
    }
    
    enum Filter: String, CaseIterable {
        case 최신순
        case 인기순
        case 할인율순
        case 낮은가격순
        case 높은가격순
    }
    
    var filterSheet: some View {
        ScrollView {
            VStack {
                Spacer(minLength: 20)
                Button {
                    filter = .최신순
                    shouldShowSheetPresent = false
                } label: {
                    Text("\(Filter.최신순.rawValue)")
                        .padding()
                }
               
                Divider()
                Button {
                    filter = .인기순
                    shouldShowSheetPresent = false
                } label: {
                    Text("\(Filter.인기순.rawValue)")
                        .padding()
                }
                Divider()
                Button {
                    filter = .할인율순
                    shouldShowSheetPresent = false
                } label: {
                    Text("\(Filter.할인율순.rawValue)")
                        .padding()
                }
                Divider()
                Button {
                    filter = .낮은가격순
                    shouldShowSheetPresent = false
                } label: {
                    Text("\(Filter.낮은가격순.rawValue)")
                        .padding()
                }
                Divider()
                Button {
                    filter = .높은가격순
                    shouldShowSheetPresent = false
                } label: {
                    Text("\(Filter.높은가격순.rawValue)")
                        .padding()
                }
            }
            .foregroundColor(.black)
        }
    }
}

struct FilterBar_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        FilterBar(gifticons: gifticons)
    }
}
