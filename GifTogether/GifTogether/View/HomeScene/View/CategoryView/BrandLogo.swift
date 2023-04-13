//
//  BrandLogo.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/24.
//

import SwiftUI

struct BrandLogo: View {
    var brand: Brand
    
    var body: some View {
        VStack {
            Image(brand.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
            Text(brand.name)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(uiColor: .white))
        .cornerRadius(16)
    }
}

struct BrandLogo_Previews: PreviewProvider {
    static var previews: some View {
        BrandLogo(brand: .starbucks)
    }
}
