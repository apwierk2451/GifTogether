//
//  LoginView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/17.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = DIContainer().makeLoginViewModel()
    
    @State var isValidEmail: Bool = false
    @State var isValidPassword: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    
    @State var shouldShowSignupView: Bool = false
    @State var shouldShowMainView: Bool = false
    @State var showLoading: Bool = false
    @State var showError: Bool = false
    
    var isValidButton: Binding<Bool> {
        .init {
            isValidEmail && isValidPassword
        } set: { _ in
            
        }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Label {
                    Text("GifTogether에 로그인 하세요")
                        .font(.title2)
                } icon: {
                    Image(systemName: "lock.open.display")
                        .font(.title)
                }.padding()
                
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
                
                NormalButton(isValid: isValidButton, title: "로그인")
                    .onTapGesture {
                        hideKeyboard()
                        showLoading = true
                        tryLogin()
                    }
                    .disabled(!isValidButton.wrappedValue)
                
                NavigationLink(isActive: $shouldShowSignupView) {
                    SignupView(shouldShowSignupView:$shouldShowSignupView)
                        .environmentObject(viewModel)
                } label: {
                    Text("회원가입")
                }
                .foregroundColor(.secondary)
                
                NavigationLink("login", isActive: $shouldShowMainView) {
                    MainView(logout: $shouldShowMainView)
                        .navigationBarBackButtonHidden()
                }
                .opacity(0.0)
                .disabled(true)
                
                Spacer()
                
                ToastMessage(isSuccessAlert: false, message: "사용자 정보가 존재하지 않습니다.")
                    .scaleEffect(showError ? 1.0 : 0.0)
                    .animation(.ripple(), value: showError)
                    .onChange(of: showError) { isShowError in
                        guard isShowError else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            showError = false
                        }
                    }
            }
            .padding(.top, 100)
        }
        .overlay {
            if showLoading && !viewModel.isSuccessLogin {
                ProgressView().controlSize(.large)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            if UserDefaults.standard.value(forKey: "userUID") != nil {
                shouldShowMainView = true
            }
        }
    }
    
    private func tryLogin() {
        viewModel.login(with: email, password: password) { (isComplete) in
            if isComplete {
                shouldShowMainView = true
                showLoading = false
                email = ""
                password = ""
            } else {
                showError = true
                showLoading = false
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
