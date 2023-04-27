//
//  MainView.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/17.
//

import SwiftUI

struct MainView: View {
    @StateObject private var homeViewModel = DIContainer().makeHomeViewModel()
    @StateObject private var myPageViewModel = DIContainer().makeMyPageViewModel()
    @StateObject private var favoriteViewModel = DIContainer().makeFavoriteViewModel()
    @StateObject private var searchViewModel = DIContainer().makeSearchViewModel()
    
    @Binding var logout: Bool
    
    @State private var selection: Tab = .home
    
    @State private var shouldResetHomeTab: Bool = false
    @State private var shouldResetSearchTab: Bool = false
    @State private var shouldResetFavoriteTab: Bool = false
    @State private var shouldResetMypageTab: Bool = false
    
    var handler: Binding<Tab> {
        Binding {
            self.selection
        } set: {
            if $0 == self.selection {
                switch $0 {
                case .home:
                    shouldResetHomeTab = true
                case .search:
                    shouldResetSearchTab = true
                case .favorite:
                    shouldResetFavoriteTab = true
                case .mypage:
                    shouldResetMypageTab = true
                }
            }
            self.selection = $0
        }
    }
    
    enum Tab {
        case home
        case search
        case favorite
        case mypage
    }
    
    var body: some View {
        TabView(selection: handler) {
            HomeView(isTapped: $shouldResetHomeTab)
                .environmentObject(homeViewModel)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(Tab.home)
            
            SearchView()
                .environmentObject(searchViewModel)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tab.search)
            
            FavoriteView()
                .environmentObject(favoriteViewModel)
                .tabItem {
                    Image(systemName: "heart")
                }
                .tag(Tab.favorite)
            
            ProfileView(isMainViewPresented: $logout)
                .environmentObject(myPageViewModel)
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
                .tag(Tab.mypage)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(logout: .constant(true))
    }
}
