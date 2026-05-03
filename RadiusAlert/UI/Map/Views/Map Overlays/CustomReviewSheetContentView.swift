//
//  CustomReviewSheetContentView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-04-12.
//

import SwiftUI

struct CustomReviewSheetContentView: View {
    // MARK: INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            VStack {
                coverImage
                
                VStack {
                    title
                    secondaryText
                    
                    Spacer()
                    
                    VStack(spacing: 25) {
                        footer
                        actionButton
                    }
                }
                .padding(.horizontal, 25)
            }
            .ignoresSafeArea(.all, edges: .top)
            .toolbar { dismissButton }
        }
        .sheetCornerRadiusViewModifier
    }
}

// MARK: - PREVIEWS
#Preview("CustomReviewSheetContentView") {
    Color.clear
        .sheet(isPresented: .constant(true)) {
            CustomReviewSheetContentView()
        }
        .previewModifier()
}

// MARK: - EXTENSIONS
fileprivate extension View {
    @ViewBuilder
    func buttonBackgroundViewModifier() -> some View {
        if #available(iOS 26.0, *) {
            self
                .glassEffect(.regular.tint(.blue.opacity(0.2)), in: .capsule)
        } else {
            self
                .background(.blue.opacity(0.2), in: .rect(cornerRadius: 12))
        }
    }
}

extension CustomReviewSheetContentView {
    private var coverImage: some View {
        Image(colorScheme == .dark ? .customReviewCoverDark : .customReviewCoverLight)
            .resizable()
            .scaledToFit()
    }
    
    private var title: some View {
        Text("Enjoying Radius Alert?")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .padding(.top)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var secondaryText: some View {
        Text("If Radius Alert has ever helped you catch your stop while sleeping, we’d really appreciate a quick review.")
            .font(.title3)
            .multilineTextAlignment(.center)
    }
    
    private var footer: some View {
        Text("By tapping Continue, you will be directed to the App Store to leave a review for Radius Alert app.")
            .font(.caption)
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
    }
    
    private var actionButton: some View {
        Button {
            mapVM.setIsPresentedCustomReviewSheet(false)
            OpenURLTypes.appStoreReview.openURL()
            mapVM.userDefaultsManager.saveDidAskForReview()
        } label: {
            Text("Continue")
                .fontWeight(.semibold)
                .foregroundStyle(.blue)
                .padding(.vertical)
                .frame(width: Utilities.screenWidth * 0.7)
                .buttonBackgroundViewModifier()
        }
    }
    
    private var dismissButton: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            Button("Cancel", role: .cancel) {
                mapVM.setIsPresentedCustomReviewSheet(false)
            }
        }
    }
}
