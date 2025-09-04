//
//  ReadMeView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-09-01.
//

import SwiftUI

struct ReadMeView: View, ReadMeComponents {
    // MARK: - INJECTED PROPERTIES
    @Binding var isPresented: Bool
    
    // MARK: - INITIALIZER
    init(isPresented: Binding<Bool>) {
        _isPresented = isPresented
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            content
            dismissButton
        }
        .presentationCornerRadius(40)
    }
}

// MARK: - PREVIEWS
#Preview("Read Me") {
    @Previewable @State var isPresented: Bool = true
    
    Color.clear
        .sheet(isPresented: $isPresented) {
            ReadMeView(isPresented: $isPresented)
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
extension ReadMeView {
    private var dismissButton: some View {
        Button {
            isPresented.toggle()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(25)
        .buttonStyle(.plain)
    }
    
    private var content: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 50) {
                ReadMe_AppNameNDescriptionView()
                ReadMe_WhyView()
                ReadMe_KeyFeaturesView()
                ReadMe_HowItWorksView()
                ReadMe_UXChoicesView()
            }
            .padding(.horizontal, 50)
            .padding(.top, 110)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}
