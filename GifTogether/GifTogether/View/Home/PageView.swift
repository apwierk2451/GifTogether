//
//  PageView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct PageView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://user-images.githubusercontent.com/95114036/224049941-6126a647-21a9-4df9-8acd-4c2e40930f85.png")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 250)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView()
    }
}
