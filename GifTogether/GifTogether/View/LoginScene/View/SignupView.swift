//
//  SignupView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @Binding var shouldShowSignupView: Bool
    
    @State var isValidEmail: Bool = false
    @State var isValidPhoneNumber: Bool = false
    @State var isValidNickName: Bool = false
    @State var isValidPassword: Bool = false
    @State var isSubmitLoginInfo: Bool = false
    @State var showLoading: Bool = false
    @State var showSuccessAlert: Bool = false
    @State var showError: Bool = false
    
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var nickName: String = ""
    @State var password: String = ""
    
    var isValidButton: Binding<Bool> {
        .init {
            isValidEmail && isValidPhoneNumber &&
            isValidNickName && isValidPassword
        } set: { _ in
            
        }
    }

    var body: some View {
        
        VStack(spacing: 30) {

            Text("회원가입")
                .font(.title)
            
            NormalTextField(
                value: $email,
                isValid: $isValidEmail,
                placeholder: .constant("이메일을 입력해주세요.")
            )
            .onChange(of: email) { newValue in
                if newValue.isValidEmail() {
                    isValidEmail = true
                } else {
                    isValidEmail = false
                }
            }

            NormalTextField(
                value: $phoneNumber,
                isValid: $isValidPhoneNumber,
                placeholder: .constant("전화번호를 입력해주세요.")
            )
            .onChange(of: phoneNumber) { newValue in
                if newValue.isValidPhoneNumber() {
                    isValidPhoneNumber = true
                } else {
                    isValidPhoneNumber = false
                }
            }
            
            NormalTextField(
                value: $nickName,
                isValid: $isValidNickName,
                placeholder: .constant("닉네임을 입력해주세요.")
            )
            .onChange(of: nickName) { newValue in
                if newValue.isValidNickName() {
                    isValidNickName = true
                } else {
                    isValidNickName = false
                }
            }
            
            PasswordTextField(
                value: $password,
                isValid: $isValidPassword,
                placeholder: .constant("비밀번호를 입력해주세요.")
            )
            .onChange(of: password) { newValue in
                if newValue.isValidPassword() {
                    isValidPassword = true
                } else {
                    isValidPassword = false
                }
            }
            
            NormalButton(isValid: isValidButton, title: "회원가입")
                .onTapGesture {
                    hideKeyboard()
                    showLoading = true
                    tryCreateUser()
                }
                .disabled(!isValidButton.wrappedValue)

            Button("로그인") {
                shouldShowSignupView = false
            }
            .foregroundColor(.secondary)
            
            Spacer()
            ZStack {
                ToastMessage(isSuccessAlert: false, message: "회원가입에 실패했습니다 😭")
                    .opacity(showError ? 1 : 0)
                    .scaleEffect(showError ? 1 : 0.2)
                    .animation(.ripple(), value: showError)
                    .onChange(of: showError) { isShowError in
                        guard isShowError else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            showError = false
                        }
                    }
                
                ToastMessage(isSuccessAlert: true, message: "회원가입에 성공했습니다 🎉")
                    .opacity(showSuccessAlert ? 1 : 0)
                    .scaleEffect(showSuccessAlert ? 1 : 0.2)
                    .animation(.ripple(), value: showSuccessAlert)
                    .onChange(of: showSuccessAlert) { isShowSuccessAlert in
                        guard isShowSuccessAlert else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            showSuccessAlert = false
                            shouldShowSignupView = false
                        }
                    }
            }
        }
        .padding(.top, 30)
        .background(Color(.tertiarySystemBackground).onTapGesture {
            hideKeyboard()
        })
        .overlay {
            if showLoading && !viewModel.isSuccessSignup {
                ProgressView().controlSize(.large)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func tryCreateUser() {
        viewModel.createUser(
            with: .init(
                id: email,
                password: password,
                vendorName: nickName,
                phoneNumber: phoneNumber
            )
        ) { isComplete in
            if isComplete {
                showLoading = false
                showSuccessAlert = true
            } else {
                showLoading = false
                showError = true
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(shouldShowSignupView: .constant(true))
            .environmentObject(DIContainer().makeLoginViewModel())
    }
}
