//
//  GifTogetherApp.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/03.
//

import SwiftUI

@main
struct GifTogetherApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
