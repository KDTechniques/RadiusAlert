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
        let showPin: Bool = item.locationTitle != nil
        
        Button {
            onPinTap()
        } label: {
            Image(systemName: getSystemImageName(state))
                .font(.title3)
                .pinForegroundColor(state: state)
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
        .frame(height: 25)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .opacity(showPin ? 1 : 0)
        .disabled(!showPin)
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
    func getSystemImageName(_ state: PinAnimationState) -> String {
        switch state {
        case .none:
            return "pin.fill"
            
        case .success:
            return  "checkmark.circle.fill"
            
        case .failed:
            return "pin.fill"
        }
    }
    
    private func onPinTap() {
        Task {
            guard
                let title: String = item.locationTitle,
                let marker: MarkerModel = mapVM.getMarkerObject(on: item.markerID) else { return }
            
            let item: LocationPinsModel = .init(
                title: title,
                radius: marker.radius,
                coordinate: marker.coordinate
            )
            
            do {
                try await locationPinsVM.onPopupCardLocationPinTap(item)
                state = .success
            } catch {
                state = .failed
            }
        }
    }
}

private extension View {
    @ViewBuilder
    func pinForegroundColor(state: PinAnimationState) -> some View {
        let color: Color = {
            switch state {
            case .none:
                return .secondary
                
            case .success:
                return .green
                
            case .failed:
                return .yellow
            }
        }()
        
        self
            .foregroundStyle(color.gradient)
    }
}
