//
//  GridTestView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/31.
//

import SwiftUI

struct GridTestView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @State var isCompleteLoading: Bool = false
    @State var shouldShowDetailView: Bool = false

    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var title: String
    var body: some View {
        VStack {
            FilterBar(gifticons: viewModel.searchedGifticon)
            
            Divider()
            if isCompleteLoading {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.searchedGifticon, id:\.uuid) { gifticon in
                            NavigationLink(isActive: $shouldShowDetailView) {
                                DetailView(gifticon: gifticon)
                            } label: {
                                GridGifticon(gifticon: gifticon)
                                    .padding()
                            }
                        }
                    }
                }
                .navigationTitle(title)
            } else {
                VStack {
                    Spacer()
                    ProgressView().controlSize(.large)
                    Spacer()
                }
                .navigationTitle(title)
            }
        }
        .task {
            viewModel.search(text: title, maxCount: 10) {
                isCompleteLoading = true
            }
        }
        .onDisappear {
            guard shouldShowDetailView == false else { return }
            viewModel.updateQuery(maxCount: 10)
        }
    }
}

struct GridTestView_Previews: PreviewProvider {
    static var gifticons = [Gifticon.stub()]
    
    static var previews: some View {
        GridTestView(title: "추천상품")
            .environmentObject(DIContainer().makeSearchViewModel())
    }
}
