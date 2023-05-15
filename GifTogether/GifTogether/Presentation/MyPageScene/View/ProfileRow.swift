//
//  ProfileRow.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/18.
//

import SwiftUI

struct ProfileRow: View {
    var userInfo: UserInfo
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 100, height: 100)
                .foregroundColor(.cyan)
                .padding(.leading, 50)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(userInfo.name)
                    .font(.title2)
                    .bold()
            }
            .padding(.trailing, 60)
        }
        .frame(width: UIScreen.main.bounds.width-20, height: 200)
        .background(Color(.tertiarySystemBackground))
        .cornerRadius(16)
        .shadow(radius: 8)
        
    }
}

struct ProfileRow_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRow(
            userInfo: UserInfo(uuid: "", name: "wongbing",
                               email: "wb233@naver.com",
                               phoneNumber: "01012341212",
                               favoriteList: [],
                               salesList: []))
    }
}
