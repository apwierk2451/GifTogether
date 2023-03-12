//
//  HomeView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct HomeView: View {
    
    var body: some View {
            List {
                PageView()
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
        }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
