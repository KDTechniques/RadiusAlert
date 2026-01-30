//
//  ReadMeView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-09-07.
//

import SwiftUI

struct ReadMeView: View {
    // MARK: - INJECTED PROPERTIES
    @Binding var isPresented: Bool
    
    // MARK: - INITIALIZER
    init(_ isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var animate: Bool = false
    let padding: CGFloat = 20
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ReadMe_IntroductionView(animate: $animate)
                ReadMe_HighlightsView(hPadding: padding, animate: animate)
                
                LazyVStack(alignment: .leading, spacing: 10) {
                    ReadMe_HeadingSection1View()
                    ReadMe_HeadingSection2View()
                    ReadMe_HeadingSection3View()
                    ReadMe_HeadingSection4View()
                    ReadMe_HeadingSection5View()
                    ReadMe_HeadingSection6View()
                    ReadMe_HeadingSection7View()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(padding)
            }
        }
        .overlay(alignment: .topTrailing) { dismissButton }
    }
}

// MARK: - PREVIEWS
#Preview("ReadMeView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            ReadMeView(.constant(true))
                .sheetCornerRadiusViewModifier
        }
}

// MARK: - EXTENSIONS
extension ReadMeView {
    private var dismissButton: some View {
        ReadMe_DismissButtonView { isPresented = false }
            .padding(padding)
    }
    
    
}
