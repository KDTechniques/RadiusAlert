//
//  PopupCardToolBarView.swift
//  RadiusAlert
//
//  Created by Mr. Kavinda Dilshan on 2025-08-09.
//

import SwiftUI
import CoreLocation

enum PinAnimationState {
    case none
    case success
    case failed
}

struct PopupCardToolBarView: View {
    // MARK: - INJECTED PROPERTIERS
    @Environment(LocationPinsViewModel.self) private var locationPinsVM
    @Environment(MapViewModel.self) private var mapVM
    let item: PopupCardModel
    
    // MARK: - ASSIGNED PROPERTIES
    @State private var state: PinAnimationState = .none
    
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
        .animation(.default, value: state)
        .frame(height: 25)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .opacity(showPin() ? 1 : 0)
        .disabled(disablePin())
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
    private func getSystemImage(_ state: PinAnimationState) -> some View {
        switch state {
        case .none:
            Image(systemName: "pin.fill")
                .foregroundStyle(.secondary)
            
        case .success:
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(.green)
            
        case .failed:
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundStyle(.yellow)
        }
    }
    
    private func showPin() -> Bool {
        guard let coordinate: CLLocationCoordinate2D = mapVM.getMarkerObject(on: item.markerID)?.coordinate else { return false }
        
        let condition1: Bool = locationPinsVM.locationPinsArray.contains(where: { $0.isSameCoordinate(coordinate) })
        let condition2: Bool = item.locationTitle.isNil()
        let condition3: Bool = state != .none
        
        return (!condition1 && !condition2) || (condition1 && condition3)
    }
    
    private func disablePin() -> Bool {
        let condition1: Bool = showPin()
        let condition2: Bool = (state == .none)
        
        return !condition1 && condition2
    }
    
    private func handleTap() {
        locationPinsVM.onPopupCardPinTap(item: item) {
            state = .success
        } failure: {
            state = .failed
        }
    }
}
