//
//  HomeView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
        List {
            BannerView()
                .listRowInsets(EdgeInsets())
            CategoryRow(items: Category.allCases)
                .padding(.top)
                .listRowInsets(EdgeInsets())
            GifticonRow(categoryName: "추천상품", items: homeViewModel.gifticonsInfo)
                .listRowInsets(EdgeInsets())
        }
        .listStyle(.inset)
        .navigationTitle("GifTogether")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Image(systemName: "bell"))
        .navigationBarBackButtonHidden()
        .task {
            homeViewModel.request()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}
