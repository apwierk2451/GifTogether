//
//  ToastMessage.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/06.
//

import SwiftUI

struct ToastMessage: View {
    @State var isSuccessAlert: Bool
    var message: String
    
    var body: some View {
        Text(message)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(Color(uiColor: isSuccessAlert ? .darkGray : .red).opacity(0.7))
            .foregroundColor(.white)
            .cornerRadius(9)
    }
}

struct ToastMessage_Previews: PreviewProvider {
    
    static var previews: some View {
        ToastMessage(isSuccessAlert: false, message: "로그인에 실패했습니다.")
    }
}
