//
//  MoreSavedLocationPinsButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-11-03.
//

import SwiftUI

struct MoreSavedLocationPinsButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(LocationPinsViewModel.self) private var savedPinsVM
    
    // MARK: - BODY
    var body: some View {
        Button {
            savedPinsVM.setIsPresentedSavedLocationsSheet(true)
        } label: {
            if #available(iOS 26.0, *) {
                Image(systemName: "ellipsis")
                    .font(.subheadline)
                    .foregroundStyle(Color.accentColor)
                    .frame(width: savedPinsVM.horizontalPinButtonsHeight, height: savedPinsVM.horizontalPinButtonsHeight)
                    .background(.regularMaterial)
                    .clipShape(.circle)
                    .glassEffect(.clear)
            } else {
                Label("More", systemImage: "ellipsis")
                    .font(.subheadline)
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(.regularMaterial)
                    .clipShape(.capsule)
                    .overlay {
                        Capsule()
                            .strokeBorder(.primary.opacity(0.2), lineWidth: 0.6)
                    }
                
            }
        }
        .buttonStyle(.plain)
        .sheet(isPresented: savedPinsVM.isPresentedSavedLocationsSheetBinding()) {
            LocationPinsListView()
                .presentationDetents([.medium])
                .presentationCornerRadius
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
    }
}
