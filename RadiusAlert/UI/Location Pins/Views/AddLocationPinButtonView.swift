//
//  AddLocationPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct AddLocationPinButtonView: View {
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    
    // MARK: - BODY
    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                glassButton
            } else {
                nonGlassButton
            }
        }
        .sheet(isPresented: locationPinsVM.isPresentedLocationSavingSheetBinding()) {
            AddLocationPinSheetContentView()
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color.init(uiColor: .systemGray6))
        }
    }
}

// MARK: - PREVIEWS
#Preview("AddLocationPinButtonView") {
    AddLocationPinButtonView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension AddLocationPinButtonView {
    private var buttonLabel: some View {
        Image(systemName: "pin.fill")
            .foregroundStyle(Color.accentColor)
            .frame(width: 44, height: 44)
            .mapControlButtonBackground
            .defaultTypeSizeViewModifier
    }
    
    private func buttonAction() {
        locationPinsVM.onAddNewLocationPinButtonTap()
    }
    
    private var nonGlassButton: some View {
        Button {
            buttonAction()
        } label: {
            buttonLabel
        }
        .mapControlButtonShadow
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                buttonAction()
            } label: {
                buttonLabel
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
