//
//  DetailView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/03/13.
//

import SwiftUI

struct DetailView: View {
    var gifticon: Gifticon
    var favoriteViewModel = DIContainer().makeFavoriteViewModel()
    @State private var shouldShowShare = false
    @State private var shouldShowMore = false
    @State private var navigationLinkActive = false
    
    var body: some View {
        VStack {
            ScrollView {
                GifticonDetail(gifticon: gifticon)
                    .listRowInsets(EdgeInsets())
            }
            
            GifticonPurchase(gifticon: gifticon)
                .environmentObject(favoriteViewModel)
                .navigationTitle("상세보기")
                .navigationBarTitleDisplayMode(.inline)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                HStack {
                    Button {
                        shouldShowShare = true
                        actionSheet()
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    Spacer()
                    Button {
                        shouldShowMore = true
                    } label: {
                        Label("More", systemImage: "ellipsis")
                            .rotationEffect(Angle(degrees: 90))
                    }
                }
            }
        }
        .actionSheet(isPresented: $shouldShowMore) {
            ActionSheet(title: Text("게시물 신고하기"),
                        buttons: [
                            .destructive(
                                Text("신고"),
                                action: {
                                    navigationLinkActive = true
                                }
                            ),
                            .cancel(Text("취소"))])
        }
        
        if navigationLinkActive {
            NavigationLink("", destination: ReportView(gifticon: gifticon), isActive: $navigationLinkActive)
        }
    }
    
    private func actionSheet() {
        //        guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
        let shareText = "\(gifticon.name)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var gifticon = Gifticon.stub()
    
    static var previews: some View {
        DetailView(gifticon: gifticon)
    }
}
