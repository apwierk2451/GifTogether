//
//  View+.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/03.
//

import SwiftUI
import UIKit

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
