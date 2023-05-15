//
//  NormalTextField.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/18.
//

import SwiftUI

struct NormalTextField: View {
    @Binding var value: String
    @Binding var isValid: Bool
    @Binding var placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $value)
            .padding()
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(16)
            .padding(.leading)
            .padding(.trailing)
            .overlay(alignment: .trailing) {
                if isValid {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                        .padding(.trailing, 30)
                }
            }
    }
}

struct NormalTextField_Previews: PreviewProvider {
    static var previews: some View {
        NormalTextField(value: .constant(""), isValid: .constant(true), placeholder: .constant("비밀번호를 입력해아"))
    }
}
