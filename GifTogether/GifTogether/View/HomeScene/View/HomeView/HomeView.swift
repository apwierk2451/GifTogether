//
//  HomeView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/09.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var showHiddenMenu: Bool = false
    @State var showModal: Bool = false
    
    var body: some View {
        ZStack {
            List {
                BannerView()
                    .listRowInsets(EdgeInsets())
                CategoryRow(items: Category.allCases)
                    .padding(.top)
                    .listRowInsets(EdgeInsets())
                GifticonRow(
                    categoryName: "추천상품",
                    items: homeViewModel.gifticonsInfo
                )
                .padding(.top)
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("GifTogether")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Image(systemName: "bell"))
            .navigationBarBackButtonHidden()
            .task {
                homeViewModel.request()
            }

            Color(uiColor: .black).opacity(showHiddenMenu ? 0.5 : 0.0)
                .animation(Animation.easeInOut(duration: 0.3))
                .onTapGesture {
                    showHiddenMenu.toggle()
                }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    ZStack {
                        Text("내 기프티콘 판매")
                            .font(.body)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(Color(uiColor: .orange).cornerRadius(8))
                            .offset(x: showHiddenMenu ? -20 : 0, y: showHiddenMenu ? -60 : 0)
                            .scaleEffect(showHiddenMenu ? 1.0 : 0)
                            .animation(.ripple(), value: showHiddenMenu)
                            .sheet(isPresented: $showModal) {
                                CategorySelectView(shouldPresent: $showModal)
                            }
                            .onTapGesture {
                                showModal = true
                                showHiddenMenu = false
                            }
                        
                        Image(systemName: showHiddenMenu ? "xmark.circle.fill" : "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .scaleEffect(showHiddenMenu ? 0.8 : 1.0)
                            .animation(.ripple(), value: showHiddenMenu)
                            .foregroundColor(showHiddenMenu ? .secondary : .orange)
                            .background(Color(uiColor: .white).cornerRadius(25).scaleEffect(0.8))
                            .padding()
                            .padding(.leading, 40)
                            .onTapGesture {
                                showHiddenMenu.toggle()
                            }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DIContainer().makeHomeViewModel())
    }
}
