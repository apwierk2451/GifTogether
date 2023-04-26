//
//  SaleItem.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/03/19.
//

import SwiftUI

struct SaleItem: View {
    var gifticon: Gifticon
    @EnvironmentObject var viewModel: MyPageViewModel
    @Binding var showDeleteAlert: Bool
    
    var body: some View {
        VStack() {
            AsyncImage(url: URL(string: gifticon.imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else if phase.error != nil || phase.image == nil {
                    Image(systemName: "nosign")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(0.6)
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
                    .foregroundColor(.black)
                Text("\(gifticon.originalPrice)원")
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.bottom)
        }
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 6)
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
        SaleItem(gifticon: .stub(), showDeleteAlert: .constant(false))
    }
}
