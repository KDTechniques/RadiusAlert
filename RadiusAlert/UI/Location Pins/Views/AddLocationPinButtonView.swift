//
//  AddLocationPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct AddLocationPinButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
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
        .opacity(locationPinsVM.showAddNewLocationPinButton() ? 1 : 0)
        .disabled(!locationPinsVM.showAddNewLocationPinButton())
        .animation(.default, value: locationPinsVM.showAddNewLocationPinButton())
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
        Image(systemName: "pin")
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
                .foregroundStyle(Color.accentColor)
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
                    .bold()
                    .foregroundStyle(colorScheme == .dark ? .white : Color.accentColor)
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
