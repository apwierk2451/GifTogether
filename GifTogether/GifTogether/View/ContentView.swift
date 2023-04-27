//
//  ContentView.swift
//  GifTogether
//
//  Created by 이원빈, 이은찬 on 2023/03/03.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        LoginView()
            .onAppear {
                UIApplication.shared.hideKeyboard()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
