//
//  GifticonRegisterView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/08.
//

import SwiftUI

struct GifticonRegisterView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @Binding var shouldPresent: Bool
    
    @State private var showProgress: Bool = false
    @State private var showSuccessAlert: Bool = false
    
    @State private var categoryText: String = ""
    @State private var brandText: String = ""
    @State private var nameText: String = ""
    @State private var codeNumberText: String = ""
    @State private var originalPriceText: String = ""
    @State private var discountedPriceText: String = ""
    @State private var expirationDateText: String = ""
    @State private var selectedDate: Date = Date()
    
    var category: Category
    var brand: Brand
    var isValidButton: Binding<Bool> {
        .init {
            nameText.isEmpty == false && codeNumberText.isEmpty == false &&
            originalPriceText.isEmpty == false && discountedPriceText.isEmpty == false
        } set: { _ in
            
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("카테고리 : ")
                Text(category.title)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            HStack {
                Text("브랜드 : ")
                Text(brand.name)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            HStack {
                Text("이름 : ")
                TextField("", text: $nameText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            HStack {
                Text("코드번호 : ")
                TextField("", text: $codeNumberText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
            }
            
            HStack {
                Text("원가 : ")
                TextField("", text: $originalPriceText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                Text("할인가 : ")
                TextField("", text: $discountedPriceText)
                    .padding()
                    .background(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(16)
                    .padding(.leading)
                    .padding(.trailing)
                    .keyboardType(.decimalPad)
            }
            
            HStack {
                DatePicker("유효기간",
                           selection: $selectedDate,
                           displayedComponents: [.date])
            }
            
            NormalButton(isValid: isValidButton, title: "등록하기")
                .padding(.top, 30)
                .onTapGesture {
                    hideKeyboard()
                    showProgress = true
                    
                    guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
                        return
                    }
                    viewModel.register(gifticon: .init(uuid: UUID().uuidString,
                                                       name: nameText,
                                                       codeNumber: codeNumberText,
                                                       brand: brand,
                                                       category: category,
                                                       originalPrice: originalPriceText,
                                                       discountedPrice: discountedPriceText,
                                                       imageURL: "",
                                                       expirationDate:
                                                       DateManager.shared.toString(date: selectedDate),
                                                       providerUID: userUID,
                                                       favoriteCount: 0)) {
                        showProgress = false
                        showSuccessAlert = true
                    }
                }
            Spacer()
        }
        .overlay {
            if showProgress {
                ProgressView()
                    .controlSize(.large)
            }
            VStack {
                Spacer()
                ToastMessage(isSuccessAlert: true, message: "기프티콘이 등록되었습니다 🎉")
                    .scaleEffect(showSuccessAlert ? 1.0 : 0.0)
                    .animation(.ripple(), value: showSuccessAlert)
                    .onChange(of: showSuccessAlert) { isShowSuccessAlert in
                        guard isShowSuccessAlert else { return }
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                            showSuccessAlert = false
                            shouldPresent = false
                        }
                    }
            }
        }
        .padding()
    }
}

struct GifticonRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        GifticonRegisterView(shouldPresent: .constant(true), category: .bakery, brand: .dunkinDonut)
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}
