//
//  SettingView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var viewModel: MyPageViewModel
    @State var isEnableAlarm = UIApplication.shared.isRegisteredForRemoteNotifications
    @State var showLogoutAlert: Bool = false
    @State var showDeleteAccountAlert: Bool = false
    @State var showDeleteAccountSuccessAlert: Bool = false
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
                    .onChange(of: isEnableAlarm) { newValue in
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                        // MARK: 알림 설정 값 수정이 되는지 확인 후 구현하기
//                        if newValue {
//                            UIApplication.shared.registerForRemoteNotifications()
//                        } else {
//                            UIApplication.shared.unregisterForRemoteNotifications()
//                        }
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
                        showLogoutAlert = true
                    }
                    .foregroundColor(Color("writeColor"))
                    .alert("로그아웃 하시겠습니까?", isPresented: $showLogoutAlert) {
                        Button("예", role: .cancel) {
                            viewModel.logout()
                            isMainViewPresented = false
                        }
                        Button("아니오", role: .destructive) {}
                    }
                    
                    Button("탈퇴하기") {
                        showDeleteAccountAlert = true
                    }
                    .foregroundColor(Color("writeColor"))
                    .alert("회원탈퇴 하시겠습니까?",
                           isPresented: $showDeleteAccountAlert) {
                        Button("예", role: .cancel) {
                            viewModel.deleteAccount {
                                showDeleteAccountSuccessAlert = true
                            }
                        }
                        Button("아니오", role: .destructive) {}
                    }
                    .alert("정상적으로 계정이 삭제 되었습니다.",
                           isPresented: $showDeleteAccountSuccessAlert) {
                        Button("확인", role: .cancel) {
                            isMainViewPresented = false
                        }
                    }
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isMainViewPresented: .constant(false))
            .environmentObject(DIContainer().makeMyPageViewModel())
    }
}
