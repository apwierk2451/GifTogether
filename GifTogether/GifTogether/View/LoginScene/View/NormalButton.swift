//
//  LoginButton.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import SwiftUI

struct NormalButton: View {
    @Binding var isValid: Bool
    var title: String
    
    var body: some View {
        Text(title)
        .padding()
        .padding(.leading, 160)
        .padding(.trailing, 160)
        .background(Color(isValid ? .systemGreen : .systemGray))
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        NormalButton(isValid: .constant(true), title: "로그인")
    }
}
