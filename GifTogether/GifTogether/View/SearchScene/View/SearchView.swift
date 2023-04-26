//
//  SearchView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @State private var shouldShowNextView: Bool = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText,
                          shouldShowNextView: $shouldShowNextView,
                          viewModel: viewModel)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                Text(viewModel.searchQueries.isEmpty ? "최근 검색어 없음" : "최근 검색어 목록")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(
                            searchText == "" ? viewModel.searchQueries : viewModel.searchQueries.filter { $0.query.hasPrefix(searchText)},
                            id: \.id
                        ) { gifticonQuery in
                            Text(gifticonQuery.query)
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                                .onTapGesture {
                                    viewModel.search(text: gifticonQuery.query, maxCount: 10) {
                                        searchText = gifticonQuery.query
                                        shouldShowNextView = true
                                    }
                                }
                        }
                    }
                }
                .padding()
                .onChange(of: shouldShowNextView) { newValue in
                    guard newValue == false else {
                        return
                    }
                    viewModel.updateQuery(maxCount: 10)
                }
                
                if searchText == "" && viewModel.searchQueries.isEmpty == false {
                    HStack {
                        Spacer()
                        Button("히스토리 삭제") {
                            viewModel.deleteAllGifticonQueries()
                        }
                        .font(.subheadline)
                        .foregroundColor(.red)
                        Spacer()
                    }
                    .padding()
                }
                
                Spacer()
                
                NavigationLink(isActive: $shouldShowNextView) {
                    GridView(gifticons: $viewModel.searchedGifticon,title: searchText)
                } label: {
                    EmptyView()
                }
            }
            .navigationTitle("기프티콘 검색")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(DIContainer().makeSearchViewModel())
    }
}
