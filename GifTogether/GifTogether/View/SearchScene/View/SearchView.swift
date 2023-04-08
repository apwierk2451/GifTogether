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
                SearchBar(text: $searchText, shouldShowNextView: $shouldShowNextView)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                NavigationLink(isActive: $shouldShowNextView) {
                    GridTestView(title: searchText)
                } label: {
                    EmptyView()
                }
                
                List {
                    Text(viewModel.searchQueries.isEmpty ? "최근 검색어 없음" : "최근 검색어 목록")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    ForEach(
                        searchText == "" ? viewModel.searchQueries : viewModel.searchQueries.filter { $0.query.hasPrefix(searchText)},
                        id: \.id
                    ) { gifticonQuery in
                        NavigationLink {
                            GridTestView(
                                title: gifticonQuery.query
                            )
                        } label: {
                            Text(gifticonQuery.query)
                        }
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
                    }
                }
                .listStyle(PlainListStyle())
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
