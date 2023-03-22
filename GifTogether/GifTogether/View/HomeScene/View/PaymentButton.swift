//
//  PaymentButton.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/20.
//

import SwiftUI

struct PaymentButton: View {
    var body: some View {
        Button {
            // TODO: 결제 진행 
        } label: {
            Text("결제하기")
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .frame(height: 20)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red)
                .cornerRadius(15)
        }
        .padding()
    }
}

struct PaymentButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentButton()
    }
}
