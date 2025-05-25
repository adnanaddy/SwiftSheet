//
//  SheetHelper.swift
//  SwiftSheet
//
//  Created by Adnan Khan AdDY on 5/22/25.
//

import SwiftUI

struct SheetConfig {
    var maxDetent: PresentationDetent
    var cornerRadius: CGFloat = 30
    var isInteractiveDismissDisabled : Bool = false
//    Add More Properties as needed
    var horizontalPadding: CGFloat = 15
    var bottomPadding: CGFloat = 15
}

extension View {
    @ViewBuilder
    func systemSheetView<Content: View>(
        _ show: Binding<Bool>,
        config: SheetConfig = .init(maxDetent: .fraction(0.99)),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .sheet(isPresented: show) {
                content()
                    .background(.background)
                    .clipShape(.rect(cornerRadius: config.cornerRadius))
                    .padding(.horizontal, config.horizontalPadding)
                    .padding(.bottom, config.bottomPadding)
                    .frame(maxHeight: .infinity, alignment: .bottom)
    //              presentation configurations
                    .presentationDetents([config.maxDetent])
                    .presentationCornerRadius(0)
                    .presentationBackground(.clear)
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
            }
    }
}

fileprivate struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view =  UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let shadowView = view.dropShadowView {
                shadowView.layer.shadowColor = UIColor.gray.cgColor
            }
        }
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
}

extension UIView {
    var dropShadowView: UIView? {
        if let superview, String(describing: type(of: superview)) == "UIDropShadowView" {
            return superview
        }
        
        return superview?.dropShadowView
    }
}
