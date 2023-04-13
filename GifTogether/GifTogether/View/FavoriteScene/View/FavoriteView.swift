//
//  FavoriteView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    
    var body: some View {
        NavigationView {
            GridView(gifticons: favoriteViewModel.filteredGifticons, title: "찜한 상품")
        }
        .task {
            favoriteViewModel.fetchFavoriteGifticons()
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
            .environmentObject(DIContainer().makeFavoriteViewModel())
    }
}
