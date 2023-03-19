//
//  PasswordTextField.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/18.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var value: String
    @Binding var isValid: Bool
    @Binding var placeholder: String
    
    var body: some View {
        SecureField(placeholder, text: $value)
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

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(value: .constant(""), isValid: .constant(true), placeholder: .constant(""))
    }
}
