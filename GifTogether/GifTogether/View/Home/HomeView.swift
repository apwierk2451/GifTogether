//
//  HomeView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
        NavigationView {
            List {
                PageView()
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("GifTogether")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image(systemName: "bell"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
