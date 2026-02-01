//
//  AddPinOrAddMultipleStopsMapBottomTrailingButtonView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2026-01-08.
//

import SwiftUI

struct AddPinOrAddMultipleStopsMapBottomTrailingButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    @Environment(MapViewModel.self) private var mapVM
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    
    let type: AddPinOrAddMultipleStops
    
    // MARK: - INITIALIZER
    init(type: AddPinOrAddMultipleStops) {
        self.type = type
    }
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var alertManager: AlertManager = .shared
    
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
#Preview("AddPinOrAddMultipleStopsMapBottomTrailingButtonView") {
    Preview()
        .previewModifier()
}

fileprivate struct Preview: View {
    @Environment(MapViewModel.self) private var mapVM
    @State private var type: AddPinOrAddMultipleStops = .addPin
    
    var body: some View {
        AddPinOrAddMultipleStopsMapBottomTrailingButtonView(type: type)
            .allowsHitTesting(false)
            .overlay {
                Color.primary.opacity(0.001)
                    .onTapGesture {
                        type = (type == .addPin) ? .addMultipleStops : .addPin
                    }
            }
    }
}

// MARK: - EXTENSIONS
extension AddPinOrAddMultipleStopsMapBottomTrailingButtonView {
    private var buttonLabel: some View {
        MapControlButtonBackgroundView(size: .init(width: 44, height: 44)) {
            Group {
                switch type {
                case .addPin:
                    Image(systemName: type.rawValue)
                        .frame(width: 44, height: 44)
                        .transition(.slide)
                    
                case .addMultipleStops:
                    Image(systemName: type.rawValue)
                        .frame(width: 44, height: 44)
                        .transition(.slide)
                }
            }
            .animation(.bouncy, value: type)
        }
        .defaultTypeSizeViewModifier
    }
    
    private func buttonAction() {
        switch type {
        case .addPin:
            locationPinsVM.onAddNewLocationPinButtonTap()
            
        case .addMultipleStops:
            mapVM.alertManager.showAlert(
                .addMultipleStops(viewLevel: .content) {
                    // add logic here later...
                } manual: {
                    mapVM.setIsPresentedMultipleStopsMapSheet(true)
                }
            )
        }
    }
    
    private var nonGlassButton: some View {
        Button {
            buttonAction()
        } label: {
            buttonLabel
        }
    }
    
    @ViewBuilder
    private var glassButton: some View {
        if #available(iOS 26.0, *) {
            Button {
                buttonAction()
            } label: {
                buttonLabel
                    .fontWeight(.semibold)
                    .foregroundStyle(colorScheme == .dark ? .white : Color.accentColor)
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
