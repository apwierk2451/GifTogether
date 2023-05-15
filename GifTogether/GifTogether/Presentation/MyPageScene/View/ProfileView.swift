//
//  ProfileView.swift
//  GifTogether
//
//  Created by 이은찬, 이원빈 on 2023/03/09.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    @Binding var isMainViewPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("내 정보")
                        .bold()
                        .padding(.leading, 30)
                        .foregroundColor(.secondary)
                        .font(.title3)
                    
                    ProfileRow(userInfo: viewModel.userInfo)
                        .padding()
                    
                    Text("판매중인 상품")
                        .bold()
                        .padding(.leading, 30)
                        .foregroundColor(.secondary)
                        .font(.title3)
                    
                    SaleGifticonList()
                }
                .onAppear {
                    viewModel.fetchUserInfo()
                }
                .navigationTitle("마이페이지")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    NavigationLink {
                        SettingView(isMainViewPresented: $isMainViewPresented)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .background(Color(.systemBackground))
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isMainViewPresented: .constant(false))
            .environmentObject(DIContainer().makeMyPageViewModel())
    }
}
