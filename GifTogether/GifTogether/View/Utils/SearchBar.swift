//
//  SearchBar.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/07.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var shouldShowNextView: Bool
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
                    .toolbar {
                        ToolbarItemGroup(placement:.keyboard) {
                            Spacer()
                            Button {
                                hideKeyboard()
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
                    .onSubmit {
                        shouldShowNextView = true
                    }
                    .submitLabel(.search)
                
                Button {
                    self.text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .opacity(text.isEmpty ? 0.0 : 1.0)
            }
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        SearchBar(text: $text, shouldShowNextView: .constant(false))
    }
}
