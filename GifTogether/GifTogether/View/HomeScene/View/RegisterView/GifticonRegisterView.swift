//
//  GifticonRegisterView.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/08.
//

import SwiftUI
import Vision
import VisionKit

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
    
    @State private var showingImagePicker = false
    @State var pickedImage: Image?
    @State var pickedUIImage: UIImage?
    var category: Category
    var brand: Brand
    var isValidButton: Binding<Bool> {
        .init {
            nameText.isEmpty == false &&
            originalPriceText.isEmpty == false &&
            discountedPriceText.isEmpty == false
        } set: { _ in
            
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                if pickedImage == nil {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .foregroundColor(.gray)
                } else {
                    pickedImage?.resizable()
                        .scaledToFit()
                        .frame(width: 150)
                }
                
                Button(action: {
                    self.showingImagePicker.toggle()
                }, label: {
                    Text("기프티콘 이미지 선택")
                }).sheet(isPresented: $showingImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.pickedUIImage = image
                        self.pickedImage = Image(uiImage: image)
                        recognizeText(image: image)
                    }
                }
                .padding()
                
                Text("기프티콘의 코드번호와 바코드가 유출되지 않도록 유의해주세요!")
                    .font(.callout)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color(.systemRed).opacity(0.9))
                    .cornerRadius(8)
                    .padding()
                
                HStack {
                    Text("카테고리 : ")
                    Text(category.title)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(16)
                    Text("  브랜드 : ")
                    Text(brand.name)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(16)
                }
                
                HStack {
                    Text("유효기간 : ")
                    DatePicker(selection: $selectedDate, displayedComponents: [.date]) {}
                        .labelsHidden()
                        .environment(\.locale, Locale.init(identifier: "ko_KR"))
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
                
                NormalButton(isValid: isValidButton, title: "등록하기")
                    .padding(.top, 30)
                    .onTapGesture {
                        hideKeyboard()
                        showProgress = true
                        
                        guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
                            return
                        }
                        let imageUUID = UUID().uuidString
                        registerGifticon(with: imageUUID, user: userUID)
                    }
                    .disabled(!isValidButton.wrappedValue)
                Spacer()
            }
            .padding()
            .background(Color(.tertiarySystemBackground).onTapGesture {
                hideKeyboard()
            })
            .overlay {
                if showProgress {
                    ProgressView()
                        .controlSize(.large)
                }
                VStack {
                    Spacer()
                    ToastMessage(isSuccessAlert: true, message: "기프티콘이 등록되었습니다 🎉")
                        .scaleEffect(showSuccessAlert ? 1.0 : 0.2)
                        .opacity(showSuccessAlert ? 1 : 0)
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
        }
    }
    
    private func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else {
            fatalError("could not get image")
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ request, error in
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                return
            }
            
            let gifticonNumber = observations.filter {
                $0.topCandidates(1).first?.string.isCodeNumber() ?? false
            }.first?.topCandidates(1).first?.string
            
            let expirationDate = observations.filter {
                $0.topCandidates(1).first?.string.isDate() ?? false
            }.first?.topCandidates(1).first?.string
            
            guard let gifticonNumber = gifticonNumber,
                  let expirationDate = expirationDate?.toDate() else { return }
            
            codeNumberText = gifticonNumber
            selectedDate = expirationDate
        }
        request.recognitionLanguages =  ["ko-KR"]
        request.usesLanguageCorrection = true
        
        do {
            try handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    private func registerGifticon(with imageUUID: String, user userUID: String) {
        
        viewModel.fetchImageURL(
            from: pickedUIImage?.jpegData(compressionQuality: 1) ?? Data(),
            fileName: imageUUID
        ) { url in
            
            viewModel.register(
                gifticon: .init(
                    uuid: imageUUID,
                    name: nameText,
                    codeNumber: codeNumberText,
                    brand: brand,
                    category: category,
                    originalPrice: originalPriceText,
                    discountedPrice: discountedPriceText,
                    imageURL: url?.absoluteString ?? "",
                    expirationDate: DateManager.shared.toString(date: selectedDate),
                    providerUID: userUID,
                    favoriteCount: 0
                )
            ) {
                showProgress = false
                showSuccessAlert = true
            }
        }
    }
}

struct GifticonRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        GifticonRegisterView(shouldPresent: .constant(true), category: .bakery, brand: .dunkinDonut)
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}
