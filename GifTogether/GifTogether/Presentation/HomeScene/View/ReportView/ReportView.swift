//
//  ReportView.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/05/06.
//

import SwiftUI

struct ReportView: View {
    
    private let viewModel = DIContainer().makeReportViewModel()
    
    @State var text: String = ""
    @Environment(\.dismiss) private var dismiss
    let gifticon: Gifticon
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(0.25)
                .frame(width: 400, height: 300)
                .overlay {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $text)
                            .font(.body)
                            .padding()
                        
                        if text.isEmpty {
                            Text("신고할 내용을 입력하세요.")
                                .lineSpacing(10)
                                .foregroundColor(.gray)
                                .padding(20)
                        }
                    }
                }
            
            NormalButton(isValid: .constant(!text.isEmpty), title: "운영팀에게 보내기")
                .padding()
                .onTapGesture {
                    guard let userUID = UserDefaults.standard.string(forKey: "userUID") else {
                        return
                    }
                    
                    let report = Report(uuid: UUID().uuidString,
                                        suspect: gifticon.providerUID,
                                        victim: userUID,
                                        content: text
                    )
                    viewModel.request(report: report)
                    dismiss()
                }
            Spacer()
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(gifticon: .stub())
    }
}
