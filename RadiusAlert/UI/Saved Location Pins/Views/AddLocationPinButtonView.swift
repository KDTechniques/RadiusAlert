//
//  AddLocationPinButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-11-04.
//

import SwiftUI

struct AddLocationPinButtonView: View {
    @Environment(MapViewModel.self) private var mapVM
    @Environment(SavedLocationPinsViewModel.self) private var savedPinsVM
    
    // MARK: - BODY
    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                glassButton
            } else {
                nonGlassButton
            }
        }
        .sheet(isPresented: .constant(true)/*savedPinsVM.isPresentedLocationSavingSheetBinding()*/) {
            AddLocationPinSheetContentView()
                .presentationDetents([.fraction(0.4)])
                .presentationCornerRadius
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
    
    private var nonGlassButton: some View {
        Button {
            savedPinsVM.setIsPresentedLocationSavingSheet(true)
        } label: {
            buttonLabel
        }
        .mapControlButtonShadow
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                savedPinsVM.setIsPresentedLocationSavingSheet(true)
                
                //                if let result = mapVM.selectedSearchResult {
                //                    print(result.result.name)
                //                    print(result.result.location.coordinate)
                //                    print(mapVM.selectedRadius.description)
                //                } else {
                //                    print(mapVM.centerCoordinate.debugDescription)
                //                    print(mapVM.selectedRadius.description)
                //                    print(mapVM.getRadiusTextString(mapVM.selectedRadius, withAlertRadiusText: false))
                //                }
                
            } label: {
                buttonLabel
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
