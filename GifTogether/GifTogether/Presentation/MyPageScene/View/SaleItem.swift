//
//  SaleItem.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SaleItem: View {
    let gifticon: Gifticon
    @EnvironmentObject var viewModel: MyPageViewModel
    @State private var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack() {
            AsyncImage(url: URL(string: gifticon.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else if phase.error != nil || phase.image == nil {
                    Image("placeholder")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.7)
                        .frame(width: 150, height: 150)
                } else {
                    ProgressView()
                }
            }
            VStack {
                Text(gifticon.brand.name)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(gifticon.name)
                    .font(.headline)
                    .foregroundColor(Color("writeColor"))
                    .lineLimit(2)
                Text("\(gifticon.originalPrice)원")
                    .font(.subheadline)
                    .foregroundColor(Color("writeColor"))
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 6)
        .frame(width: UIScreen.main.bounds.width / 2.5)
        .overlay {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showDeleteAlert = true
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.red)
                            .alert("삭제 하시겠습니까?", isPresented: $showDeleteAlert) {
                                Button("예", role: .cancel) {
                                    viewModel.deleteGifticon(gifticonUUID: gifticon.uuid) {
                                        viewModel.fetchUserInfo()
                                        showDeleteAlert = false
                                    }
                                }
                                Button("아니오", role: .destructive) {}
                            }
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

struct SaleItem_Previews: PreviewProvider {
    static var previews: some View {
        SaleItem(gifticon: .stub(name: "티라미수 + 아메리카노 (R) 2잔"))
    }
}
