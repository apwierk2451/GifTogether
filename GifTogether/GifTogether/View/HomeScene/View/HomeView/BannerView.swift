//
//  BannerView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct BannerView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://user-images.githubusercontent.com/95114036/237077511-6304797b-b773-4f39-9404-86f8cac22881.png")) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
        }
        .frame(height: 250)
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
