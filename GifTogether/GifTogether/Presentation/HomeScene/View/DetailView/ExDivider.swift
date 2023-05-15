//
//  ExDivider.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/20.
//

import SwiftUI

struct ExDivider: View {
    let color: Color = Color(.systemGray3)
    let height: CGFloat = 10
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: height)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
