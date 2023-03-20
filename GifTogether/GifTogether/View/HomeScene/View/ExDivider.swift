//
//  ExDivider.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/20.
//

import SwiftUI

struct ExDivider: View {
    let color: Color = .init(red: 0.9, green: 0.9, blue: 0.9)
    let width: CGFloat = 10
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
