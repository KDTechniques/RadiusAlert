//
//  AddMultipleStopsButtonView.swift
//  RadiusAlert
//
//  Created by Kavinda Dilshan on 2025-12-23.
//

import SwiftUI

struct AddMultipleStopsButtonView: View {
    // MARK: - INJECTED PROPERTIES
    @Environment(\.colorScheme) private var colorScheme
    
    @Environment(MapViewModel.self) private var mapVM
    let locationManager: LocationManager = .shared
    
    // MARK: - BODY
    var body: some View {
        Group {
            if #available(iOS 26.0, *) {
                glassButton
            } else {
                nonGlassButton
            }
        }
    }
}

// MARK: - PREVIEWS
#Preview("AddMultipleStopsButtonView") {
    AddMultipleStopsButtonView()
        .previewModifier()
}

// MARK: - EXTENSIONS
extension AddMultipleStopsButtonView {
    private var buttonLabel: some View {
        Image(systemName: "plus")
            .frame(width: 44, height: 44)
            .mapControlButtonBackground
            .defaultTypeSizeViewModifier
    }
    
    private func buttonAction() {
        
        #if DEBUG
        Task {
            guard
                let currentUserLocation = locationManager.markerCoordinate,
                let centerCoordinate = mapVM.centerCoordinate,
                let route = await locationManager.getRoute(pointA: currentUserLocation, pointB: centerCoordinate) else { return }
            
            mapVM.setRoute(route)
        }
        #endif
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
                    .fontWeight(.semibold)
                    .foregroundStyle(colorScheme == .dark ? .white : Color.accentColor)
                    .glassEffect(.regular)
            }
            .buttonStyle(.plain)
        }
    }
}
