//
//  AboutReadMeView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-05.
//

import SwiftUI

struct AboutReadMeView: View {
    // MARK: - ASSIGNED PROPERTIES
    @State private var isPresented: Bool = false
    
    // MARK: - BODY
    var body: some View {
        Button("Read Me") {
            isPresented = true
        }
        .sheet(isPresented: $isPresented) {
            ReadMeTestingView($isPresented)
                .presentationCornerRadius(40)
        }
    }
}

// MARK: - PREVIEWS
#Preview("AboutReadMeView") {
    AboutReadMeView()
        .previewModifier()
}
