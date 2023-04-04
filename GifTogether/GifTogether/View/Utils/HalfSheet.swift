//
//  HalfSheet.swift
//  GifTogether
//
//  Created by 이은찬 on 2023/04/03.
//

import SwiftUI
import UIKit

extension View {
    func halfSheet<SheetView: View>(showSheet: Binding<Bool>, @ViewBuilder sheetView: @escaping () -> SheetView) -> some View {
        
        return self
            .background(
                HalfSheetHelper(sheetView: sheetView(),
                                showSheet: showSheet)
            )
    }
}

struct HalfSheetHelper<SheetView: View>: UIViewControllerRepresentable {
    var sheetView: SheetView
    @Binding var showSheet: Bool
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> UIViewController {
        controller.view.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        
        if showSheet {
            let sheetController = CustomHostingController(rootView: sheetView)
            
            viewController.present(sheetController, animated: true)
        } else {
            viewController.dismiss(animated: true)
        }
    }
}

final class CustomHostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLoad() {
        super.viewDidLoad()
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [
                .medium(),
                .large()
            ]
            
            presentationController.prefersGrabberVisible = true
        }
    }
}
