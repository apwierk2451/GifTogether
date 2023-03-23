//
//  SettingView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SettingView: View {
    @State var isEnableAlarm: Bool = false
    @Binding var isMainViewPresented: Bool
    
    var body: some View {
        VStack() {
            List {
                Section(
                    header: Text("알림 설정")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                ) {
                    Toggle(isOn: $isEnableAlarm) {
                        Text("이벤트/ 마케팅 알림")
                    }
                }
                
                Section(
                    header: Text("정보")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.secondary)
                ) {
                    NavigationLink("개인정보처리방침") {
                        PersonalInfomation()
                    }
                    
                    NavigationLink("이용약관") {
                        AgreementOfUtilization()
                    }
                }
                
                Section(header: Text("계정")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.secondary)
                ) {
                    Button("로그아웃") {
                        isMainViewPresented = false
                    }
                    .foregroundColor(.black)
                    
                    Button("탈퇴하기") {
                        // TODO: 회원탈퇴 Action
                    }
                    .foregroundColor(.black)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isMainViewPresented: .constant(false))
    }
}
