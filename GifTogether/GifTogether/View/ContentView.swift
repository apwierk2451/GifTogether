//
//  ContentView.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .home
    @StateObject private var homeViewModel = HomeViewModel()
    
    enum Tab {
        case home
        case search
        case favorite
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .environmentObject(homeViewModel)
                .tabItem {
                    Image(systemName: "house")
                }
                .tag(Tab.home)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .tag(Tab.search)
            
            FavoriteView()
                .tabItem {
                    Image(systemName: "heart")

                }
                .tag(Tab.favorite)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                }
                .tag(Tab.profile)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
