//
//  UIApplication+.swift
//  GifTogether
//
//  Created by 이원빈 on 2023/04/27.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func hideKeyboard() {
        guard let window = windows.first else { return }
        let tapRecognizer = UITapGestureRecognizer(
            target: window,
            action: #selector(UIView.endEditing(_:))
        )
        tapRecognizer.cancelsTouchesInView = false
        tapRecognizer.delegate = self
        window.addGestureRecognizer(tapRecognizer)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        
        return false
    }
}
