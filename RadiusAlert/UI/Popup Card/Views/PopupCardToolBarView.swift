//
//  PopupCardToolBarView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI
import CoreLocation

struct PopupCardToolBarView: View {
    // MARK: - INJECTED PROPERTIERS
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(MapViewModel.self) private var mapVM
    let item: PopupCardModel
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var state: PopupCardLocationPinStates = .none
    
    // MARK: - INITIALIZER
    init(item: PopupCardModel) {
        self.item = item
    }
    
    // MARK: - BODY
    var body: some View {
        Button {
            handleTap()
        } label: {
            getSystemImage(state)
                .font(.title3)
        }
        .buttonStyle(.plain)
        .frame(height: 25)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .opacity(locationPinsVM.showLocationPinOnPopupCard(item: item, state: state) ? 1 : 0)
        .animation(.default, value: state)
        .disabled(locationPinsVM.disableLocationPinOnPopupCard(item: item, state: state))
        .padding(.top)
    }
}

// MARK: - PREVIEWS
#Preview("Popup Card ToolBar") {
    PopupCardToolBarView(item: .mock)
        .padding(.horizontal)
        .previewModifier()
}

// MARK: - EXTENSIONS
extension PopupCardToolBarView {
    @ViewBuilder
    private func getSystemImage(_ state: PopupCardLocationPinStates) -> some View {
        switch state {
        case .none:
            Image(systemName: "pin.fill")
                .foregroundStyle(Color.secondary.gradient)
            
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green.gradient)
            
        case .failed:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.yellow.gradient)
        }
    }
    
    private func handleTap() {
        locationPinsVM.onPopupCardPinTap(item: item) {
            state = .success
        } failure: {
            state = .failed
        }
    }
}
